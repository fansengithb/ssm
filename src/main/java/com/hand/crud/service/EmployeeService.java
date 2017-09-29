package com.hand.crud.service;

import com.hand.crud.bean.Employee;
import com.hand.crud.bean.EmployeeExample;
import com.hand.crud.bean.EmployeeExample.Criteria;
import com.hand.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("employeeService")
public class EmployeeService {
	
	@Autowired
	@Qualifier("employeeMapper")
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param empName
	 * @return  true：代表当前姓名可用   fasle：不可用
	 */
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 * @param
	 */

	public  void  updateEmp(Employee employee){

		employeeMapper.updateByPrimaryKeySelective(employee);
	}


	///罗俊修改---3
//	public Map<String,Object> updateEmp(Employee employee){
//		Map<String,Object> sMap = new HashMap<String,Object>();
//		int n = employeeMapper.updateByPrimaryKeySelective(employee);
//		if(n==1){
//			sMap.put("success",true);
//			sMap.put("msg","更新员工信息成功");
//		}else{
//			sMap.put("success",false);
//			sMap.put("msg","更新员工信息失败");
//		}
//		return  sMap;
//	}


//	public void updateEmp(Employee employee) {
//		// TODO Auto-generated method stub
//		employeeMapper.updateByPrimaryKeySelective(employee);
//	}

	/**
	 * 员工删除
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
