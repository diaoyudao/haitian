<?php
namespace Admin\Common;

class DeleteTime
{
    /**
     * 失效数据。
     * @return boolean
     */
    static function delete($model,$where)
    {
        $data['delete_time'] = (new \DateTime())->format('Y-m-d H:i:s');
        $ret = $model->where($where)->save($data);
        return $ret;
    }
    /**
     * 生效数据。
     * @return boolean
     */
    static function active($model, $where)
    {
        $data['delete_time'] = null;
        $ret = $model->where($where)->save($data);
        return $ret;
    }
}