<?php
namespace Admin\Controller\Upload;

use Think\Controller;

class ImageController extends Controller
{

    public function upload()
    {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize = C('UPLOAD_IMAGE_MAX_SIZE') * 1024 *1024 ;// 设置附件上传大小
        $upload->exts = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath = C('IMAGE_SAVE_PATH_ROOT'); // 设置附件上传根目录
        $upload->savePath = C('IMAGE_SAVE_PATH'); // 设置附件上传（子）目录
        $upload->saveName = md5(uniqid());
        $upload->subName = '/';       // 禁止自动添加子目录
        $upload->saveExt = 'jpg';    // 文件名后缀统一采用jpg

        // 上传文件
        $info = $upload->upload();
        if (!$info) {
            // 上传错误提示错误信息

            $this->ajaxReturn(['status' => 'failed', 'message' => '失败：' . $upload->getError()]);
        } else {// 上传成功
            $image_url = C('IMAGE_SAVE_PATH') . '/' . $upload->saveName . '.' . $upload->saveExt;

            if (is_file(C('IMAGE_SAVE_PATH_ROOT') . $image_url)) {
                if ('' != (I('get.thb', ''))) {  // 需要生成缩略图
                    $thumbnail_width = I('get.w', '100', FILTER_VALIDATE_INT);
                    $thumbnail_height = I('get.h', '100', FILTER_VALIDATE_INT);
                    $thumbnail_url = C('IMAGE_PREVIEW_PATH') . '/' . $upload->saveName . '.thb';
                    // 创建缩略图
                    \Admin\Common\Image::createPreviewImage(C('IMAGE_SAVE_PATH_ROOT') . $image_url,
                        $thumbnail_width, $thumbnail_height, C('IMAGE_SAVE_PATH_ROOT') . $thumbnail_url);

                    if(is_file(C('IMAGE_SAVE_PATH_ROOT') . $thumbnail_url)) {
                        if(!\Admin\Common\Image::createImageTransToArcPng(C('IMAGE_SAVE_PATH_ROOT') . $thumbnail_url,
                            C('IMAGE_SAVE_PATH_ROOT') . $thumbnail_url)) {
                            $this->ajaxReturn(['status' => 'failed', 'message' => '转换圆形图片失败']);
                        }
                    }
                }
            }
            clearstatcache();

            $this->ajaxReturn(['status' => 'ok', 'image_url' => $image_url, 'thumbnail_url' => isset($thumbnail_url) ? $thumbnail_url : '']);
        }
    }

    public function preview()
    {
        // (new \Admin\Common\Upload\Image\Preview())->show();
    }
}