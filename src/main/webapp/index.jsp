<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%--引入cforeach--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%--<%--%>
    <%--pageContext.setAttribute("APP_PATH", request.getContextPath());--%>
    <%--%>--%>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>

                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="hidden" name="empId" id="EmpID">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <%--用于显示错误提示信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input1" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">-关闭-</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn1" >*更新*</button>
            </div>
        </div>
    </div>
</div>



<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <%--用于显示错误提示信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input1" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">-关闭-</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn1" >*保存*</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面--%>
<div class="container"></div>
<%--标题行--%>
<div class="row">
    <div class="col-md-12 col-md-offset-1">
        <h1>SSM_CRUD</h1>
    </div>
</div>
<%--按钮--%>
<div class="container">
    <div class="row">
        <%--按钮位置偏移--%>
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>

    <div class="row">
        <div class="col-md-12">
            <%--以表格形式显示员工信息--%>
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>

                </tr>

                </thead>
                <tbody>
<%--ajax填充表格--%>
                </tbody>


            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>

        <div class="col-md-12 col-md-offset-8" id="page_nav_area">


        </div>

    </div>

</div>

<script type="text/javascript">
    //页面加载完成以后，直接发送ajax请求，要到分页数据

    var currentPage;   ///记录当前页数
//    刚开始进入页面时，进入第一个页面
    $(function(){
//        去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
//                alert("aaa");
//                console.log(result);
//                解析并显示员工信息
                build_emps_table(result);
//                解析并显示分页信息
                build_page_info(result);
//                解析并显示分页条信息
                build_page_nav(result);
            }
        });

    }
    function build_emps_table(result){
        ///清空table表格数据
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
//            构建员工显示的tr
//           alert(item.empName)
            var empIdTd =$("<tr></tr>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailId = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
//            为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")
                    .addClass("glyphicon glyphicon-trash"))
                .append("删除");
//            为删除按钮添加一个自定义属性，用来表示当前员工id
            delBtn.attr("del-id",item.empId);
            var  btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后，还是返回原来的元素
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailId)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");

        });
    }
    ///解析显示分页信息
     function build_page_info(result) {
//        清空页面信息
        $("#page_info_area").empty();
         $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页," +
             "总"+result.extend.pageInfo.pages+"页，" +
             "共"+result.extend.pageInfo.total+" 条数据");
             currentPage = result.extend.pageInfo.pageNum;
     }
    ///解析显示分页条
    function build_page_nav(result) {
//        清空页面信息
        $("#page_nav_area").empty();
        var ul= $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
//        当没有前一页时，前一页按钮无效
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum -1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));


//        没有下一页时的按钮处理
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum +1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ///添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示

        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item))
//            点击到当前页面时，产生颜色加深效果
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

//    点击新增安钮，弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清楚表单数据
        $("#empAddModal form")[0].reset();
//        发送ajax请求，查出部门信息,显示在下拉列表

        getDepts("#dept_add_select");

//        弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
//    查出部门信息，显示在下拉列表中
    function getDepts(ele) {
//        清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
//                extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"
//                 在浏览器控制台中显示
//                  console.log(result)
//                显示部门信息，在下拉列表中
//                $("dept_add_select").append()
                $.each(result.extend.depts,function(){
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单的数据
    function validate_add_form() {
        ///拿到校验的数据，通过正则表达式校验
        var empName=$("#empName_add_input").val();
        //    a到z，或A到Z，或0到9，或_，或-，中的6到16位 或者中文字符2到5位
        var regName =/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        //用户名校验
        if(!regName.test(empName)){
//            alert("用户名可以是2-5为中文或者6-16英文数字组合");
//            $("#empName_add_input").parent().addClass("has-error");
            ///错误提示信息
//            $("#empName_add_input").next("span").text("用户名可以是2-5为中文或者6-16英文数字组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else {
//            $("#empName_add_input").parent().addClass("has-success");
//            $("#empName_add_input").next("span").text("");
            show_validate_msg("#empName_add_input", "success", "");


        };
//        alert(regName.test(empName));
        //邮箱信息
        var  email=$("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
//            alert("邮箱格式不正确！");
//            应该清空元素之前的样式
//            $("#empName_add_input").parent().addClass("has-error");
//            $("#empName_add_input").next("span").text("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else {
//            $("#empName_add_input").parent().addClass("has-success");
//            $("#empName_add_input").next("span").text("");
            show_validate_msg("#email_add_input", "success", "");

        };
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn1").attr("ajax-va","success");  ///保存成功
                }else{
                    show_validate_msg("#empName_add_input","error","用户名不可用");
                    $("#emp_save_btn1").attr("ajax-va","error");      ///保存失败
                }
            }
        });
    });


//    点击保存按钮后的监听事件
      $("#emp_save_btn1").click(function () {
//          模态框中填写的数据提交给服务器
//          1--先要对提交的数据进行校验
          if(!validate_add_form()){
              return false;
          };
//         1-- 判断之前的ajax用户名校验是否成功，如果成功

          if($(this).attr("ajax-va")=="error"){
              return false;
          }


//          2--发送ajax请求，保存员工
//          alert($("#empAddModal form").serialize());
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
//                    alert(result.msg);
//                员工保存成功，1---关闭模态框，2---来到最后一页，显示保存数据
                 $("#empAddModal").modal('hide');

//                 发送ajax请求后，显示最后一页数据
                    to_page(6666);
                }
            })

      });


      ////点击编辑按钮之后的，点击事件
      $(document).on("click",".edit_btn",function () {
//          alert("edit");
//          1 查出显示员工信息，
//          2  查出部门信息，并显示部门列表
//          getDepts("#dept_add_select");

//          弹出模态框
          getDepts("#empUpdateModal select");

//          把员工的id传递给模态框的更新按钮


//          查询员工信息
          getEmp($(this).attr("edit-id"));

//          把员工id传递给模态框的更新按钮
          $("#emp_update_btn1").attr("edit-id",$(this).attr("edit-id"));
          $("#empUpdateModal").modal({
              backdrop:"static"
          });
      });

//      查询员工信息
       function getEmp(id) {
           $.ajax({
               url:"${APP_PATH}/emp/"+id,
               type:"GET",
               success:function (result) {
//                console.log(result);
                   var empData = result.extend.emp;
                   $("#empName_update_static").text(empData.empName);
                   $("#EmpID").val(empData.empId);
                   $("#email_update_input").val(empData.email);
                   $("#empUpdateModal input[name=gender]").val([empData.gender]);
                   $("#empUpdateModal select").val([empData.dId]);
               }
           });
       }

//       点击更新按钮，更新员工信息
      $("#emp_update_btn1").click(function () {
          ///1-----验证邮箱是否合法

          //邮箱信息
//          var  email=$("#email_update_input").val();
//          var regEmail = /^([a-z0-9_\.-]+)@([\da-z\ .-]+)\.([a-z\.]{2,6})$/;
//          if(!regEmail.test(email)){
//              show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
//              return false;
//          }else {
//              show_validate_msg("#email_update_input", "success", "");
//
//          }

//          2----发送ajax请求，保存员工更新的数据
          $.ajax({
              url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
              type:"PUT",
              dateType: "json",
              data:$("#empUpdateModal form").serialize(),
              success:function (result) {
//                  alert(result.msg);
//              1 关闭对话框
                  $("#empUpdateModal").modal("hide");
//               2 回到本页面
                  to_page(currentPage);

              }
          });

//          罗俊修改---1（共修改 3 部）

          <%--$.ajax({--%>
              <%--url:"${APP_PATH}/upDateEmp",--%>
              <%--type:"POST",--%>
              <%--dateType: "json",--%>
              <%--data:$("#empUpdateModal form").serialize(),--%>
              <%--success:function (result) {--%>
                  <%--alert(result.msg);--%>
              <%--}--%>
          <%--});--%>

      });

//   单个删除
    $(document).on("click",".delete_btn",function () {
//        1---弹出是否确认删除的对话框(显示内容为，将要删除员工姓名)
//        var empName = $(this).parent("tr").find("td:eq(0)").text;
//        var empId = $(this).attr("del-id");
         alert($(this).parents("tr").find("td:eq(0)").text());
//          弹出确认框
        <%--if (confirm("确认删除【"+empName+"】吗？")){--%>
<%--//            如果点击确认，发送ajax请求--%>
            <%--$.ajax({--%>
                <%--url:"${APP_PATH}/emp/"+empId,--%>
                <%--type:"DELETE",--%>
                <%--success:function (result) {--%>
                    <%--alert(result.msg);--%>
<%--//                    回到本页--%>
                    <%--to_page(currentPage);--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    });
</script>

</body>
</html>