<?php
namespace Admin\Controller\Upload;

use Think\Controller;

/**
 * 大文件处理类
 * Class ProcessController
 * @package Admin\Controller\Largefile
 */
class LargefileController extends Controller
{
    const TEMP_FILE_EXT = 'block';

    public function upload()
    {
        try {
            (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                'name' => ['type' => 'string'],
                'lastModifiedDate' => ['type' => 'string'],
                'size' => ['type' => 'integer'],
            ]);
        } catch (\Exception $ex) {

			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        $paramter = I('post.');
        $file_md5 = md5($paramter['name'] . $paramter['size']);		

        $chunk = I('post.chunk','-1', FILTER_VALIDATE_INT);

        if(0 > $chunk) {
            $this->uploadOneFile($paramter, $file_md5);
        } else {
            $this->uploadChunkFile($paramter, $file_md5);
        }
    }

    private function uploadChunkFile($paramter, $file_md5)
    {
        $upload = new \Admin\Common\Upload\File();// 实例化上传类
        $upload->maxSize = C('UPLOAD_LARGE_FILE_ONCE_SIZE');// 设置附件上传大小
        $upload->rootPath = C('UPLOAD_LARGE_FILE_ROOT_PATH'); // 设置附件上传根目录
        $upload->savePath = C('UPLOAD_LARGE_FILE_TEMP_PATH') . $file_md5 . '/'; // 设置附件上传（子）目录
        $upload->saveName = (string)$paramter['chunk'];
        $upload->saveExt = self::TEMP_FILE_EXT;

        // 上传文件
        $info = $upload->upload();
        if (!$info) {
            \Think\Log::write('error:' . $upload->getError());

            $this->ajaxReturn(['status' => 'failed', 'message' => '失败：' . $upload->getError()]);
        } else {// 上传成功
            $this->savePercentage($paramter, $file_md5);

            $this->ajaxReturn(['status' => 'ok']);
        }
    }

    private function uploadOneFile($paramter, $file_md5)
    {
        $upload = new \Admin\Common\Upload\File();// 实例化上传类
        $upload->maxSize = C('UPLOAD_LARGE_FILE_ONCE_SIZE');// 设置附件上传大小
        $upload->rootPath = C('UPLOAD_LARGE_FILE_ROOT_PATH'); // 设置附件上传根目录
        $upload->savePath = C('UPLOAD_LARGE_FILE_SAVE_PATH'); // 设置附件上传（子）目录
        $upload->saveName = $paramter['name'];
        $upload->saveExt = '';

        // 上传文件
        $info = $upload->upload();
        if (!$info) {
            \Think\Log::write('error:' . $upload->getError());

            $this->ajaxReturn(['status' => 'failed', 'message' => '失败：' . $upload->getError()]);
        } else {// 上传成功
            $this->saveDb($paramter, $file_md5);

            $this->ajaxReturn(['status' => 'ok', 'url' => C('UPLOAD_LARGE_FILE_SAVE_PATH') . $paramter['name']]);
        }
    }

    private function savePercentage($paramter, $file_md5)
    {
        $model = M('LargeFileTemp');
        $datas = $model->where("file_md5 = '%s'", $file_md5)->select();
        if ($datas) {
            $percentage = percentage();
            if ($percentage > $datas[0]['percentage'] && $percentage < 100) {
                $data['percentage'] = $percentage;
                $model->where("file_md5 = '%s'", $file_md5)->save($data);
            }
        }
    }

    /**
     * 验证接口
     */
    public function check()
    {
        $type = I('post.type', '');
        if ('percentage' == $type) {			
            $this->checkPercentage();
        } else if ('initFile' == $type) {
            $this->initFile();
        } else if ('checkBlock' == $type) {
            $this->checkBlock();
        } else if ('mergeBlock' == $type) {
            $this->mergeBlock();
        }
    }

    private function checkPercentage()
    {
        $paramter = $this->checkParameter();
        $dir_md5 = $this->getFileMd5($paramter);

        $model = M('LargeFileTemp');
        $datas = $model->where("file_md5 = '%s'", $dir_md5)->select();
        if ($datas) {
            $url = $datas[0]['url'];
            $percentage = $datas[0]['percentage'];
        } else {
            $url = '';
            $percentage = 0;
        }

        $this->ajaxReturn(['status' => 'ok', 'url' => $url, 'percentage' => $percentage]);
    }

    /**
     * 初始化大文件上传临时文件夹
     */
    private function initFile()
    {
        $paramter = $this->checkParameter();
        $dir_md5 = $this->getFileMd5($paramter);

        $model = M('LargeFileTemp');
        $datas = $model->where("file_md5 = '%s' and percentage = 100", $dir_md5)->select();
        if ($datas) {
            $this->ajaxReturn(['status' => 'ok', 'complete' => true, 'url' => $datas[0]['url']]);  // 文件已经上传完毕
        } else {
            // 检查文件夹是否存在，不存在创建
            $dir = C('UPLOAD_LARGE_FILE_ROOT_PATH') . C('UPLOAD_LARGE_FILE_TEMP_PATH') . $dir_md5;
            c_dir($dir);
        }

        $this->ajaxReturn(['status' => 'ok']);
    }

    /**
     * 验证片段是否存在
     */
    private function checkBlock()
    {
        $paramter = $this->checkParameter();
        $chunk = I('post.chunk', -1, FILTER_VALIDATE_INT);
        $size = I('post.size', -1, FILTER_VALIDATE_INT);
        if (0 > $thunk || 0 > $size) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        $dir_md5 = $this->getFileMd5($paramter);

        $filename = C('UPLOAD_LARGE_FILE_ROOT_PATH') . C('UPLOAD_LARGE_FILE_TEMP_PATH')
            . $dir_md5 . '/' . $chunk . '.' . self::TEMP_FILE_EXT;

        // 判断文件是否存在，存在则不重复上传
        if (is_file($filename) && filesize($filename) == $size) {
            $this->ajaxReturn(['status' => 'ok', 'is_exists' => true]);
        }

        $this->ajaxReturn(['status' => 'ok']);
    }

    /**
     * 合并文件
     */
    private function mergeBlock()
    {
        try {
            (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                'uniqueFileName' => ['type' => 'string'],
                'name' => ['type' => 'string'],
                'chunks' => ['type' => 'integer'],
                'size' => ['type' => 'integer'],
            ]);
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        $paramter = I('post.');

        $dir_md5 = $this->getFileMd5($paramter);

        // 合并文件
        $ret = $this->mergeFile($dir_md5, $paramter);
        if (!$ret) {
            $this->ajaxReturn(['status' => 'failed', 'message' => 'merge失败']);
        }

        // 记录数据库
        $ret = $this->saveDb($paramter, $dir_md5);
        if ($ret) {
            $this->ajaxReturn(['status' => 'ok', 'url' => C('UPLOAD_LARGE_FILE_SAVE_PATH') . $paramter['name']]);
        }
        $this->ajaxReturn(['status' => 'failed', 'message' => 'db失败']);
    }

    private function mergeFile($dir_md5, $paramter)
    {
        $targetDir = C('UPLOAD_LARGE_FILE_ROOT_PATH') . C('UPLOAD_LARGE_FILE_TEMP_PATH') . $dir_md5;
        // 检查对应文件夹中的分块文件数量是否和总数保持一致
        if ((count(scandir($targetDir)) - 2) >= $paramter['chunks']) {
            $finalName = C('UPLOAD_LARGE_FILE_ROOT_PATH') . C('UPLOAD_LARGE_FILE_SAVE_PATH') . $paramter['name'];
            $ret = merg_file($finalName, $targetDir, $paramter['chunks']);

            return true;
        }
        return false;
    }

    private function saveDb($paramter, $md5)
    {
        $model = M('LargeFileTemp');
        $count = $model->where("file_md5 = '%s'", $md5)->count();
        if ($count > 0) {
            $data['percentage'] = 100;
            $model->where("file_md5 = '%s'", $md5)->save($data);
            return true;
        }
        $data['percentage'] = 100;
        $data['size'] = $paramter['size'];
        $data['name'] = $paramter['name'];
        $data['file_md5'] = $md5;
        $data['url'] = C('UPLOAD_LARGE_FILE_SAVE_PATH') . $paramter['name'];
        if ($model->add($data)) {
            return true;
        }

        return false;
    }

    private function checkParameter()
    {
        try {
            (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                'uniqueFileName' => ['type' => 'string'],
            ]);
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        return I('post.');
    }

    private function getFileMd5($paramter)
    {
        return $paramter['uniqueFileName'];
    }
}