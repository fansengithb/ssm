package com.hand.crud.controller;

import com.hand.crud.bean.Department;
import com.hand.crud.bean.Msg;
import com.hand.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 *
 * 处理和部门有关的请求
 * Created by fansen on 2017/8/31.
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    //返回所有的部门信息
    public Msg getDepts(){
        //查出的所有部门信息
        List<Department> list= departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
