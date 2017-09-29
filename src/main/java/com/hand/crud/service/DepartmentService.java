package com.hand.crud.service;

import com.hand.crud.bean.Department;
import com.hand.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by fansen on 2017/8/31.
 */

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper   departmentMapper;
    public List<Department> getDepts(){
        List<Department> list=departmentMapper.selectByExample(null);
        return list;
    }
}
