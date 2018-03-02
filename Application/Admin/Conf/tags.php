<?php
return [
    // 添加权限判断行为，在初始化控制器的时候调用
    'action_begin' => [ 'Admin\\Behaviors\\PreprocessBehavior', ],
    // 'action_end' => [       // 'Admin\\Behaviors\\ActionEndBehavior',    ],
];