<?php
namespace Admin\Controller\Test;

use Think\Controller;
use Common\Code\MyString;
use Admin\Common\Record\StaffLog;
use Admin\Common\DeleteTime;

/**
 * TEST
 */
class TestController extends Controller
{
    // 跑线上的老联系人数据
    public function index() {
        $this->depart();

        echo "<br>all end".date('Y-m-d H:i:s')."<br>";
    }
    public function depart()
    {
        echo "begin".date('Y-m-d H:i:s')."\n<br>";
        $model = M('customer_contact');
        $contact = $model->where('delete_time is null')
            ->order('customer_id,status desc, customer_contact_id')->select();

        //var_dump($contact[1]);

        echo "\n total = ". count($contact) . "\n<br>";

        $last_cust_id = $contact[0]['customer_id'];
        $weight = 10;

        foreach ($contact as $key => $item) {    
            if('100504' == $item['customer_id'])   {
                var_dump($item);
                echo "<br>";
            }     
            $where['department'] = empty($item['department'])?'未知' : $item['department'];
            $where['customer_id'] = $item['customer_id'];
            $model_depart = M('customer_department');
            $his = $model_depart->where($where)->find();
            if($his) {
                $this->changeContact($item, $his['customer_department_id']);

                $weight += 10;
                continue;
            }

            if($last_cust_id != $item['customer_id']) {
                $weight = 10;
            }

            $input['department'] = $where['department'];
            $input['customer_id'] = $item['customer_id'];
            $input['weight'] = $weight;

            $ret = $model_depart->add($input);
            if(false === $ret) {
                echo "db err".$item['customer_contact_id'].":".$model_depart->getDbError() . "\n";
                exit;
            }

            $this->changeContact($item, $ret);

            $last_cust_id = $item['customer_id'];
            $weight += 10;
        }

        echo "\n run end \n<br>";
    }

    private function changeContact($item, $department_id) {
        $model = M('customer_contact');
        $where['customer_contact_id'] = $item['customer_contact_id'];
        $data['customer_department_id'] = $department_id;
        $ret = $model->where($where)->save($data);
        if(false === $ret) {
            echo "save contact db err:".$item['customer_contact_id'].":".$model->getDbError() . "\n";
            exit;
        }
    }
}