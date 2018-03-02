<?php
namespace Admin\Controller\Send;

use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
/**
 * 发送邮件类
 */
class EmailController extends Controller
{
    const PAGE_SIZE = 100;

    private $param = [];
    private $where = [];

    public function index() {
        $province = M('province')->alias('aa')
            ->order('province_id')->select();

        $this->assign('province', $province);
        $this->display();
    }

    // 发送
    public function call() {
        $this->checkParameter('call');

        if(empty($this->param['context'])) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '短信内容不能为空！']);
        }

        $model = new OcModel('email');
        try {            
            $sms_num = count($this->param['emails']);
            // 保存发送内容到数据库，发送邮件,独立进程
            $this->saveDb();

            $model->commit();
        } catch(\Exception $ex) {
            $model->rollback();
            Log::write('发送短信失败：'. $ex->getMessage());

            $this->ajaxReturn(['status' => 'failed', 'message' => '发送短信失败']);
        }  

        $this->ajaxReturn(['status' => 'success', 'num' => $sms_num]); 
    }

    public function list() {
        $model = new OcModel('email');
        $counts = $model->alias('aa')
            ->count();
        $page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $page->show();

        $field = "aa.*";
        $data = $model->field($field)->alias('aa')
            ->page(I('pg.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
            ->order('aa.email_id')
            ->select();

        $this->assign('data', $data);
        $this->assign('counts', $counts);
        $this->assign('pager', $page);

        $this->display();
    }

    private function sendMail() {
        $filename = '/home/www/yjl/Application/Home/View/default/Mail/honestmail.tpl';
        $to_mail = M('config')->where("name = 'honest_mail'")->field('value')->select();

        $mail_app = new \Admin\Common\Mail($to_mail[0]['value'], $to_mail[0]['value']);
        $mail_app->setFileContext($filename, $parameter);
        list($status, $msg) = $mail_app->sendmail($this->param['title']);
    }

    private function saveDb() {
        $this->param['emails'] = json_encode($this->param['emails']);

        $model = new OcModel('email');
        $ret = $model->add($this->param);
        if(false === $ret) {
            E('db error:' . $model->getDbError());
        }
    }

    private function checkParameter(string $type)
    {
        try {
            if ('call' == $type) {
                (new Validator())->execute(I('post.'), [
                    'emails' => [
                        'type' => 'array',
                        'value' => [
                            'type' => 'email'
                        ]
                    ],
                    'title' => ['type' => 'string'],                    
                ]);
            }
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed'
                , 'message' => '参数错误，请检查！' . $ex->getMessage()]);
        }

        $this->param = I('');
    }
}