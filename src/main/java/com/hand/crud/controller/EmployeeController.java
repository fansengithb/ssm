package com.hand.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hand.crud.bean.Employee;
import com.hand.crud.bean.Msg;
import com.hand.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 处理员工CRUD请求
 * 
 * @author lfy
 * 
 */
@Controller
public class EmployeeController {

	@Autowired
	@Qualifier("employeeService")
	EmployeeService employeeService;


	@ResponseBody
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
	public  Msg deleteEmpById(@PathVariable("id")Integer id){
		employeeService.deleteEmp(id);
		return   Msg.success();
	}


//	保存员工
//	员工更新方法
//	请求中有数据，但是employee对象封装不上
//	原因：  tomcat:   1 将请求体中的数据封装成一个map,
//	 			    2 request.getParam("empName") 就会从这个map中取值
//					3 springMVC封装POJO对象的时候，会调用request.getParmter拿到
//		ajax发送put请求：  tomvat一看是Put请求，就不会封装请求体中的数据为map,
//							只有post请求才封装为map

//	解决方案：
/*
*   需要实现直接发送put请求，还要封装请求体中的数据
*   1 配置 HttpPutFormContentFilre
*   2 作用：将请求体中的数据包装成map
*   3 request被重新包装，request.getParamter()
*   被重写，就会从自己封装的mpper中取出员工根性方法
* */
    @ResponseBody     //把返回内容写进写进http报文的body中
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	public Msg saveEmp(Employee employee, HttpServletRequest request){
		System.out.println("请求体中的值："+request.getParameter("gender"));
		System.out.println("将要更新的员工数据："+employee);
		employeeService.updateEmp(employee);
//		更新成功后，返回成功信息
		return  Msg.success();
	}



	///罗俊修改--2
//	@RequestMapping("upDateEmp")
//	@ResponseBody
//	public Map<String,Object> upEmp(Employee employee){
//		Map<String,Object> reMap = new HashMap<String,Object>();
//		System.out.println("将要更新的员工数据============："+employee);
//		reMap = employeeService.updateEmp(employee);
//		return reMap;
//	}


//	根据id,查询员工
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public  Msg getEmp(@PathVariable("id") Integer id){
	Employee employee=employeeService.getEmp(id);
	return  Msg.success().add("emp",employee);
	}

//	检查用户是否可用
	@ResponseBody
	@RequestMapping("/checkuser")   ///处理请求
	public Msg checkuser(@RequestParam("empName") String empName){
		boolean b=employeeService.checkUser(empName);
		if(b){
			return  Msg.success();
		}else {
			return  Msg.fail();
		}
//		return  null;
	}


//	@RequestMapping(value = "/emp",method = RequestMethod.POST)
//	@ResponseBody
//	public  Msg saveEmp(Employee employee){
//		employeeService.saveEmp(employee);
//		return  Msg.success();
//	}

	/**
	 * 单个批量二合一
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * 
	 * @param
	 * @return
	 */

//	需要导入jackson包，使@responbody 起作用，将数据转换为json格式
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

		//     引入分页插件，pageHelper
//        调用pageHelper，传入页码，以及每一页显示多少条数据
		PageHelper.startPage(pn,5);
//		System.out.println(pn);
//		System.out.println("这个是employees"+employeeService);
		List<Employee> emps = employeeService.getAll();
//		System.out.println(emps);
//        使用PageInfo包装查询后的结果，pageinfo交给页面
//        pageinfo中封装了详细的分页信息，包括查询出来的数据
		PageInfo page = new PageInfo(emps,5);
		return  Msg.success().add("pageInfo",page);
	}
//	@ResponseBody
//	@RequestMapping(value="/emp/{ids}",method= RequestMethod.DELETE)


//	public Msg deleteEmp(@PathVariable("ids")String ids){
//		//批量删除
//		if(ids.contains("-")){
//			List<Integer> del_ids = new ArrayList<>();
//			String[] str_ids = ids.split("-");
//			//组装id的集合
//			for (String string : str_ids) {
//				del_ids.add(Integer.parseInt(string));
//			}
//			employeeService.deleteBatch(del_ids);
//		}else{
//			Integer id = Integer.parseInt(ids);
//			employeeService.deleteEmp(id);
//		}
//		return Msg.success();
//	}
//
//
//
//	/**
//	 * 如果直接发送ajax=PUT形式的请求
//	 * 封装的数据
//	 * Employee
//	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
//	 *
//	 * 问题：
//	 * 请求体中有数据；
//	 * 但是Employee对象封装不上；
//	 * update tbl_emp  where emp_id = 1014;
//	 *
//	 * 原因：
//	 * Tomcat：
//	 * 		1、将请求体中的数据，封装一个map。
//	 * 		2、request.getParameter("empName")就会从这个map中取值。
//	 * 		3、SpringMVC封装POJO对象的时候。
//	 * 				会把POJO中每个属性的值，request.getParamter("email");
//	 * AJAX发送PUT请求引发的血案：
//	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
//	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
//	 * org.apache.catalina.connector.Request--parseParameters() (3111);
//	 *
//	 * protected String parseBodyMethods = "POST";
//	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
//                success = true;
//                return;
//            }
//	 *
//	 *
//	 * 解决方案；
//	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
//	 * 1、配置上HttpPutFormContentFilter；
//	 * 2、他的作用；将请求体中的数据解析包装成一个map。
//	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
//	 * 员工更新方法
//	 * @param employee
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value="/emp/{empId}",method= RequestMethod.PUT)
//	public Msg saveEmp(Employee employee,HttpServletRequest request){
//		System.out.println("请求体中的值："+request.getParameter("gender"));
//		System.out.println("将要更新的员工数据："+employee);
//		employeeService.updateEmp(employee);
//		return Msg.success()	;
//	}
//
//	/**
//	 * 根据id查询员工
//	 * @param id
//	 * @return
//	 */
//	@RequestMapping(value="/emp/{id}",method= RequestMethod.GET)
//	@ResponseBody
//	public Msg getEmp(@PathVariable("id")Integer id){
//
//		Employee employee = employeeService.getEmp(id);
//		return Msg.success().add("emp", employee);
//	}
//
//
//	/**
//	 * 检查用户名是否可用
//	 * @param empName
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping("/checkuser")
//	public Msg checkuser(@RequestParam("empName")String empName){
//		//先判断用户名是否是合法的表达式;
//		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
//		if(!empName.matches(regx)){
//			return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
//		}
//
//		//数据库用户名重复校验
//		boolean b = employeeService.checkUser(empName);
//		if(b){
//			return Msg.success();
//		}else{
//			return Msg.fail().add("va_msg", "用户名不可用");
//		}
//	}
	
//
//	/**
//	 * 员工保存
//	 * 1、支持JSR303校验
//	 * 2、导入Hibernate-Validator
//	 *
//	 *
//	 * @return
//	 */
//	@RequestMapping(value="/emp",method= RequestMethod.POST)
//	@ResponseBody
//	public Msg saveEmp(@Valid Employee employee, BindingResult result){
//		if(result.hasErrors()){
//			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
//			Map<String, Object> map = new HashMap<>();
//			List<FieldError> errors = result.getFieldErrors();
//			for (FieldError fieldError : errors) {
//				System.out.println("错误的字段名："+fieldError.getField());
//				System.out.println("错误信息："+fieldError.getDefaultMessage());
//				map.put(fieldError.getField(), fieldError.getDefaultMessage());
//			}
//			return Msg.fail().add("errorFields", map);
//		}else{
//			employeeService.saveEmp(employee);
//			return Msg.success();
//		}
//
//	}
//
//	/**
//	 * 导入jackson包。
//	 * @param pn
//	 * @return
//	 */
//	@RequestMapping("/emps")
//	@ResponseBody
//	public Msg getEmpsWithJson(
//			@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
//		// 这不是一个分页查询
//		// 引入PageHelper分页插件
//		// 在查询之前只需要调用，传入页码，以及每页的大小
//		PageHelper.startPage(pn, 5);
//		// startPage后面紧跟的这个查询就是一个分页查询
//		List<Employee> emps = employeeService.getAll();
//		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
//		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
//		PageInfo page = new PageInfo(emps, 5);
//		return Msg.success().add("pageInfo", page);
//	}
	
	/**
	 * 查询员工数据（分页查询）
	 *
	 * @return
	 */
	 // @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model) {
//     引入分页插件，pageHelper
//        调用pageHelper，传入页码，以及每一页显示多少条数据
		PageHelper.startPage(pn,5);
		System.out.println(pn);
		System.out.println("这个是employees"+employeeService);
		List<Employee> emps = employeeService.getAll();
		System.out.println(emps);
//        使用PageInfo包装查询后的结果，pageinfo交给页面
//        pageinfo中封装了详细的分页信息，包括查询出来的数据
//        PageInfo page = new PageInfo(emps,5<页面显示哪几页的需要跳转的连续页>);
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
//        request.setAttribute("pageInfo",page);
//        System.out.println(page);
		return "list";
	}

}
