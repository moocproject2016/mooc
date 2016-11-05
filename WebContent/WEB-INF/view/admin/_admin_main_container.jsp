<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      //통계
       google.charts.load('current', {'packages':['annotationchart']});
      google.charts.setOnLoadCallback(drawChart1);
      function drawChart1() {

        var data = new google.visualization.DataTable();
        data.addColumn('date', 'Date');
        data.addColumn('number', '${date_5_1-1}~${date_0_1}월별 가입율');
        data.addColumn('string', 'Kepler title');
        data.addColumn('string', 'Kepler text');
        data.addColumn('number', '${date_5_1-1}~${date_0_1}총 가입자');
        data.addColumn('string', 'Gliese title');
        data.addColumn('string', 'Gliese text');
        data.addRows([
          [new Date(${date_5},${date_5_1-1}), 0, undefined, undefined,
          							 0,undefined, undefined],         
           							 
          [new Date(${date_4},${date_4_1-1}), ${dayCount_4}, undefined, undefined,
          							 ${dayCount_4},undefined, undefined],
          							 
          [new Date(${date_3},${date_3_1-1}), ${dayCount_3}, undefined, undefined,
          							 ${dayCount_4}+${dayCount_3},undefined, undefined],
          							 
          [new Date(${date_2},${date_2_1-1}), ${dayCount_2}, undefined, undefined,
         							 ${dayCount_4}+${dayCount_2}+${dayCount_3},undefined, undefined],  
         							
          [new Date(${date_1},${date_1_1-1}), ${dayCount_1}, undefined, undefined,
          						 	 ${dayCount_1}+${dayCount_2}+${dayCount_3}+${dayCount_4},undefined, undefined],        
          						 	
          [new Date(${date},${date_0_1-1},${date_0_2}), ${dayCount}, undefined, undefined,
          						 	 ${dayCount}+${dayCount_1}+${dayCount_2}+${dayCount_3}+${dayCount_4},undefined, undefined]
        ]);

        var chart = new google.visualization.AnnotationChart(document.getElementById('chart_div'));

        var options = {
          displayAnnotations: true
        };

        chart.draw(data,{vAxis: { title: "Percentage Uptime", viewWindow:{
            max:100,
            min:1
          }}});
      }
      
      
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      
    

      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['학생', ${student}],
          ['정지', ${blackStats}],
          ['강사', ${teacherStats}]
        ]);

        var piechart_options = {title:'Pie Chart',
                       width:400,
                       height:300};
        var piechart = new google.visualization.PieChart(document.getElementById('piechart_div'));
        piechart.draw(data, piechart_options);

        var barchart_options = {title:'Barchart',
                       width:400,
                       height:300,
                       legend: 'none'};
        var barchart = new google.visualization.BarChart(document.getElementById('barchart_div'));
        barchart.draw(data, barchart_options);
      }
	//미답변
		function displaySwitch(num){
			content = document.getElementById("content"+num)
			if(content.style.display=="none"){
				content.style.display="block";
			}else{
				content.style.display="none";
			}
			
		}
		
		function allCheck(){
			checkbox=document.getElementsByName("checkbox");
			if(updateform.allcheck.checked){  
				for(var i=0;i<checkbox.length;i++){
					checkbox[i].checked=true;
				}
			}else{
				for(var i=0;i<checkbox.length;i++){
					checkbox[i].checked=false;
				}
			}
		}
				
		function selectCheck(){
			var state=false;
			if(updateform.checkbox.checked==true){state=true;}
			for(var i=0;i<updateform.checkbox.length;i++){
				if(updateform.checkbox[i].checked==true){ state=true; updateform.checkbox[i].value=i; }
			}
			return state;
		}
		
		function deleteNums(){
			var updateform=document.updateform;
			if(selectCheck()==false){
				alert("삭제할 게시글을 선택해주세요.");
				return;
			}else{
				var checkIndex = new Array();
				var cnt = 0;
				for(var i=0;i<updateform.checkbox.length;i++){
					if(updateform.checkbox[i].checked==true){
						
						checkIndex[cnt] = document.getElementById("index"+ updateform.checkbox[i].value).value;
						cnt++;
					}
				}
				
				updateform.action='/mooc/admin/qnaDelete.mooc?checkIndex='+checkIndex;
				updateform.submit();
			}
		}
		
		function submitBtn(index){
			var updateform=document.updateform;
			alert("수정되었습니다.");
			updateform.action='/mooc/admin/qnaWrite.mooc?index='+index;
			updateform.submit();
		}
	</script>
    
		        <div role="tabpanel">
		            <!-- Nav tabs -->
		            <ul class="nav nav-tabs  nav-justified" role="tablist">
		                <li role="presentation" class="active">
		                	<a href="#home" aria-controls="home" role="tab" data-toggle="tab">통계</a></li>
		                <li role="presentation">
		                	<a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">미답변</a></li>
		            </ul>
		       </div>
		       		<body>
		       		<!--통계  -->
		       		 <div class="tab-content">
		                <div role="tabpanel" class="tab-pane active" id="home">
		                <br/><br/>
							 <table class="columns" align="center">
							      <tr>
							      	<td>학생 / 강사 비율</td>
							      </tr>
							      <tr>
							        <td><div id="piechart_div" ></div></td>
							        <td><div id="barchart_div" ></div><br/></td>
							      </tr>
							      <tr>
							      <td colspan="2">총가입자수 :${userCount}<br/> 
							      	${date_5_1-1}~${date_0_1}월별 가입율/${date_5_1-1}~${date_0_1}가입자<br/></td>
							 	  </tr>
							 	   <tr>
							      <td colspan="2"><br/> <div id='chart_div' style='width: 800px; height: 500px;'></div></td>
							      </tr>
							    </table>
		              	</div>
		              	
		              	
		              	<!--미답변 -->
		              	<div role="tabpanel" class="tab-pane" id="profile">
							<form name="updateform" method="post" action="/mooc/admin/qnaWrite.mooc">
									<%-- <c:set var="index" value="0" /> --%>
									<table class="table" align="center">
										<thead>
											<tr class="theadtop">
												<th><input type="checkbox" name="allcheck" onclick="allCheck()"/></th>
												<th>문의번호</th>
												<th>아이디</th>
												<th>제목</th>
												<th>문의날짜</th>
												<th>답변</th>
											</tr>
										</thead>
										<tbody>
										
											<c:forEach var="article" items="${list}" varStatus="i">
											<tr>
													
												<td align="center"><input type="checkbox" name="checkbox" value="${article.q_num}"/></td>
													<input type="hidden" name="index${i.index}" value="${article.q_num}" id="index${i.index}" />	
																		
												<td align="center">${article.q_num}
											<%-- 	<input type="text" id="num${i.index}" value="${article.q_num}"/> --%>
												</td>
												<td align="center">${article.u_id}</td>
												<td align="center" onclick="displaySwitch('${i.count}');">
													<b>${article.q_subject}</b>
												</td>
												<td align="center">${article.q_regdate}</td>
												<td align="center">
													<c:if test="${article.c_content==null}">
														미답
													</c:if>
													<c:if test="${article.c_content!=null}">
														완료
													</c:if>
												</td>				
											</tr>
													
											<c:if test="${article.q_content!=null}">
												<tr>
													
													<td colspan="7" align="left">
														<div id="content${i.count}" style="display:none; height:auto;">
															문의 내용 &nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${article.q_content}<br /><br />
															<hr>
															<form name="contentUpdate" action="/mooc/admin/qnaWrite.mooc">
																		
																	<input type="hidden" name="q_num" value="${article.q_num}"/>
																	관리자 답변 &nbsp;:&nbsp;&nbsp;
																	<textarea name="c_content" row="40" cols="100">${article.c_content}</textarea>
																	<c:if test="${article.c_content!=null}">
																		<input type="submit" value="답변수정">
																	</c:if>
																	<c:if test="${article.c_content==null}">
																		<input type="submit" value="답변등록">
																	</c:if>
															</form>
														</div>					
													</td>
													
												</tr>
											</c:if>		
											<c:set var="index" value="${index+1}" />
										</c:forEach>
											</tbody>
									</table>	
										<table class="table" align="center">
										<tr>
											
											<td align="right">
												<a onclick="deleteNums()">선택삭제</a>
											</td>					
										</tr>
									</table>
								</form>
									<table class="table" align="center">
										<tr>
											<td height="50" align="center">
												<c:if test="${count > 0}">
												
													<c:set var="pageCount" value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}" />
													<c:set var="pageBlock" value="${10}" />			
													<fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
													
													<c:set var="startPage" value="${result * 10 + 1}" />
													<c:set var="endPage" value="${startPage + pageBlock-1}" />
														<c:if test="${endPage > pageCount}">
															<c:set var="endPage" value="${pageCount}" />
														</c:if>	
																	
													<c:if test="${startPage > 10}">
														<a href="/mooc/admin.mooc?pageNum=${startPage - 10 }">[이전]</a>
													</c:if>
											
													<c:forEach var="i" begin="${startPage}" end="${endPage}">
														<a href="/mooc/admin.mooc?pageNum=${i}">[${i}]</a>
													</c:forEach>
												
													<c:if test="${endPage < pageCount}">
														<a href="/mooc/admin.mooc?pageNum=${startPage + 10}">[다음]</a>
													</c:if>
												</c:if>
											</td>
										</tr>
								</table>

		              		
		              	</div>
		              </div>
  </body>
  </head>
  </html>

