<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

        <style>
            .tableopp {padding-top: 20px;padding-bottom: 20px;color: #777;text-align: left;}
            .table-over>tbody>tr>td:hover {background-color: #f0f0f0;}
            .mask {width: 100%;height: 100%;position: fixed;left: 0;top: 0;z-index: 10;background: #000;opacity: .5;filter: alpha(opacity=50);}
            #modalLayer {display: none;position: relative;}
            .modalContent {width: 700px;height: 500px;padding: 20px;border: 1px solid #ccc;position: fixed;left: 60%;top: 60%;z-index: 11;background:#444444;opacity : 0.8;}
            .buttonA {position: absolute;right: 0;top: 0;cursor: pointe}
        </style>
        <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script>
            var modalLayer = 0;

            $(document).ready(function() {
                $(".selectbox").change(function() {
                    var selected = this.value;
                    var div = $("#" + this.name + 'div');
                    if (selected != "선택") {
                        $.ajax({
                            url: '/mooc/user/mystudy/user_sub_lecture.mooc',
                            type: "post",
                            data: {  // url 페이지도 전달할 파라미터                                    
                                main_lec_code: this.value,
                            },
                            success: function(a) {  // ajax select 박스가 합쳐지는부분
                                div.html('챕터:' + a + '<select name="ssd_type" id="selectType" class="selectbox form-control"><option>예습</option><option>복습</option><option>실시간</option></select>'
                                		+'내용:<TextArea name="ssd_content" class="form-control" style="width:98%;height:200px" />'
                                		+'<br/><input type="submit" class="btn btn-info" value="입력완료">');
                                div.show(0);
                            }
                        })
                    }
                })
                $(".modalLink").click(function() {
                    modalLayer = $("#" + this.name);
                    var modalCont = $(".modalContent");
                    var marginTop = modalCont.outerWidth() / 2;
                    var marginLeft = modalCont.outerHeight() / 2;

                    modalLayer.fadeIn(1);
                    modalCont.css({
                        "margin-top": -marginTop,
                        "margin-left": -marginLeft
                    });
                })

            })

            function out() {
                modalLayer.fadeOut(0);
                document.getElementById("selectbox").value = "선택";
                document.getElementById("sub_lec").hide(0);
            }
        </script>


        <body>
            <table style="width:97%" class="table ">
                <tr>
                    <td align="left">
                        <a href="/mooc/user/planList.mooc?currMonth=${dto.currMonth}&currYear=${dto.currYear}&action=0">
                            <font size="2">이전달</font>
                        </a>
                    </td>
                    <td align="center">
                        <b>${dto.title}</b>
                    </td>
                    <td align="right">
                        <a href="/mooc/user/planList.mooc?currMonth=${dto.currMonth}&currYear=${dto.currYear}&action=1">
                            <font size="2">다음달</font>
                        </a>
                    </td>
                </tr>
            </table>


            <table style="width:97%" class="table  ">
                <tr>
                    <td>
                        <table style="width:100%;" class="table  table-bordered table-over ">
                            <tr style="height:30px;">
                                <th>일</th>
                                <th>월</th>
                                <th>화</th>
                                <th>수</th>
                                <th>목</th>
                                <th>금</th>
                                <th>토</th>
                            </tr>

                            <c:set var="count" value="1" />
                            <c:set var="dispDay" value="1" />
                            <c:set var="check" value="1" />
                            <c:forEach var="w" begin="1" end="6" step="1">
                                <tr style="height:150px;">
                                    <c:forEach var="d" begin="1" end="7" step="1">
                                        <c:if test="${count<dto.week}">
                                            <td>&nbsp;</td>
                                        </c:if>
                                        <c:if test="${count>=dto.week}">
                                            <c:if test="${dispDay<dto.maxday}">
                                            
                                                <c:if test="${dto.title==dto.current&&dto.currDay==dispDay}">
                                                	<td class="active">
                                                </c:if>
                                                <c:if test="${dto.title!=dto.current||dto.currDay!=dispDay}">
                                                	<td>
                                                </c:if>
                                                
                                                    ${dispDay}
                                                    <c:set var="day" value="${dispDay}" />
                                                    <a class="modalLink" style="font-size:15px" name="${dispDay}">입력</a> |
                                                    <a class="modalLink" style="font-size:15px" name="${dispDay}look">상세내용 </a>

                                                    <div id="${dispDay}look" style="display:none; position:relative;">
                                                        <div class="modalContent">
                                                        	<c:forEach items="${cal}" var="data">
                                                        	 	<c:if test="${data.month==dto.title&&data.day==dispDay}">
                                                        	 	강의명 :${data.main_lec_subject}<br/>
                                                        		진도 : chapter_${data.sub_lec_chapter} : ${data.sub_lec_subject}</br/>
                                                        		목적 : ${data.ssd_type}<br/>
                                                        		내용 : ${data.ssd_content}<br/><br/>
                                                        		</c:if>
                                                        	</c:forEach>
                                                            <input type="button" class="buttonA btn  btn-primary" value="close" onclick="out();">
                                                        </div>
                                                    </div>
                                                    
                                                
                                                    <c:forEach items="${cal}" var="cal">
                                                        <c:if test="${cal.month==dto.title&&cal.day==dispDay}">  
                                                         	  <c:if test="${cal.ssd_done==0}"> 
                                                         	  	<h6 style="font-size:18px">	
                                                          			${cal.main_lec_subject} : ${cal.sub_lec_chapter}
                                                          			<a href="/mooc/user/mystudy/user_plan_check.mooc?ssd_num=${cal.ssd_num}&ssd_done=1" >
                                                            			<span class="glyphicon glyphicon-ok"></span>
                                                           			</a>
                                                           			<a href="/mooc/user/mystudy/user_plan_delete.mooc?ssd_num=${cal.ssd_num}" >
                                                            			<span class="glyphicon glyphicon-remove"></span>
                                                            		</a>
                                                            	</h6>
                                                            </c:if>
                                                            <c:if test="${cal.ssd_done==1}">
                                                            	<h6 style="font-size:18px">	
                                                            		<s>${cal.main_lec_subject} : ${cal.sub_lec_chapter}</s> 	
                                                            	<a href="/mooc/user/mystudy/user_plan_delete.mooc?ssd_num=${cal.ssd_num}" >
                                                            		<span class="glyphicon glyphicon-remove"></span>
                                                            	</a>
                                                            	</h6>
                                                            </c:if>		
            		
                                                                                                               
                                                        </c:if>
                                                    </c:forEach>

                                                    <div id="${dispDay}" style="display:none; position:relative;">
                                                        <div class="modalContent">
                                                            <form action="/mooc/user/mystudy/user_listPro.mooc" method="post">
                                                                <input type="hidden" name="ssd_date" value="${dto.title}${dispDay}">
                                                                <c:if test="${list!=null}">
                                                                  	  강의:
                                                                    <select name="${dispDay}" id="selectbox" class="selectbox form-control">
     																	<option value="선택">선택</option>
     																		<c:forEach items="${list}" var="option">
     																			<option value="${option.main_lec_code}">${option.main_lec_subject}</option>
     																		</c:forEach>
																	</select>
                                                                    <div id="${dispDay}div"></div>
                                                                </c:if>
                                                            </form>
                                                            <input type="button" class="buttonA btn btn-primary" onclick="out();" value="close">
                                                        </div>
                                                    </div>
                                                </td>

                                                <c:set var="dispDay" value="${dispDay+1}" />
                                                <c:set var="check" value="${check+1}" />
                                            </c:if>

                                            <c:if test="${dispDay>=dto.maxday&& 7>=check}">
                                                <td class='empty'></td>
                                                <c:set var="check" value="${check+1}" />
                                            </c:if>

                                        </c:if>
                                        <c:set var="count" value="${count+1}" />
                                    </c:forEach>
                                    <c:set var="check" value="1" />
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </tr>
            </table>
