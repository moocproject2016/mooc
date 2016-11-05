<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table" align="center">
	<tr>
		<td align="right">
			<a href="/mooc/user/user_categorySearchList.mooc?mainSearchValue=${mainSearchValue}&recentlyList">최신등록순</a>|
			<a href="/mooc/user/user_categorySearchList.mooc?mainSearchValue=${mainSearchValue}&popularLikeList">인기 관심 강의순</a>|
			<a href="/mooc/user/user_categorySearchList.mooc?mainSearchValue=${mainSearchValue}&popularTeacherList">인기 관심 강사순</a>|
			<a href="/mooc/user/user_categorySearchList.mooc?mainSearchValue=${mainSearchValue}&sizeReviewList">강의평 많은 순</a>
		</td>
	</tr>
</table>

<table class="table" align="center">
	<tr><td>"${mainSearchValue}" 에 대한 총 검색결과: ${mainCount+subCount+liveCount}개</td></tr>
</table>

<table class="table" align="center">
	<tr><td width="100%"><b></b><h3>실시간 강의</h3></b></td></tr>
	<tr><td>"${mainSearchValue}" 에 대한 실시간 강의 검색결과: ${liveCount}개</td></tr>
</table>
<table class="table" align="center">
	<c:if test="${liveCount>0}">
		<tr class="theadtop">
			<th align="center"></th>
			<th align="center">메인 강의</th>
			<th align="center">강의명</th>
			<th align="center">강사명</th>
			<th align="center">강의 개요</th>
			<th align="center">강의 시작 날짜</th>
		</tr>
		<c:forEach var="live_dto" items="${liveSearchList}">
			<tr>
				<td align="center" width="10%"><img src="${live_dto.main_lec_image}" style="width:90px;height:70px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${live_dto.main_lec_code}'" /></td>
				<td align="center" width="15%">${live_dto.main_lec_subject}(리뷰:${live_dto.reviewLecCount})</td>
				<td align="center"><a href="/mooc/viewMainLec.mooc?main_lec_code=${live_dto.main_lec_code}">${live_dto.sub_lec_subject}(관심강의:${live_dto.likeLectureCount})</a></td>
				<td align="center">${live_dto.u_name}(관심강사:${live_dto.likeTeacherCount})</td>
				<td align="center">${live_dto.sub_lec_content}</td>
				<td align="center">${live_dto.live_lec_date}</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${mainCount==0}">
		<tr><td colspan="6">검색결과가 없습니다.</td></tr>
	</c:if>
</table>
	
<table class="table" align="center">
	<tr><td width="100%"><b></b><h3>메인 강의</h3></b></td></tr>
	<tr><td>"${mainSearchValue}" 에 대한 메인 강의 검색결과: ${mainCount}개</td></tr>
</table>
<table class="table" align="center">
	<c:if test="${mainCount>0}">
		<tr class="theadtop">
			<th align="center"></th>
			<th align="center">분류</th>
			<th align="center">강의명</th>
			<th align="center">강사명</th>
			<th align="center">구성</th>
			<th align="center">수강신청</th>
		</tr>
		<c:forEach var="main_dto" items="${mainSearchList}">
			<tr>
				<td align="center" width="10%"><img src="${main_dto.main_lec_image}" style="width:90px;height:70px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${main_dto.main_lec_code}'" /></td>
				<td align="center" width="15%">${main_dto.sub_ctg_name}(리뷰:${main_dto.reviewLecCount})</td>
				<td align="center"><a href="/mooc/viewMainLec.mooc?main_lec_code=${main_dto.main_lec_code}">${main_dto.main_lec_subject}(관심강의:${main_dto.likeLectureCount})</a></td>
				<td align="center">${main_dto.u_name}(관심강사:${main_dto.likeTeacherCount})</td>
				<td align="center">${main_dto.main_sub_count}강</td>
				<td align="center"><input type="button" class="btn btn-default" value="수강신청" onclick="window.location='/mooc/user_lectureRegister.mooc?main_lec_code=${main_lec_dto.main_lec_code}'"/>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${mainCount==0}">
		<tr><td colspan="6">검색결과가 없습니다.</td></tr>
	</c:if>
</table>

<table class="table" align="center">
	<tr><td width="100%"><b></b><h3>서브 강의</h3></b></td></tr>
	<tr><td>"${mainSearchValue}" 에 대한 서브 강의 검색결과: ${subCount}개</td></tr>
</table>
<table class="table" align="center">
	<c:if test="${subCount>0}">
		<tr class="theadtop">
			<th align="center"></th>
			<th align="center">메인 강의</th>
			<th align="center">서브강의명</th>
			<th align="center">강의개요</th>
			<th align="center">강사명</th>
			<th align="center">미리보기</th>
		</tr>
		<c:forEach var="sub_dto" items="${subSearchList}">
			<tr>
				<td align="center" width="10%"><img src="${sub_dto.main_lec_image}" style="width:90px;height:70px"  class="img-rounded"  onclick="location.href='/mooc/viewMainLec.mooc?main_lec_code=${sub_dto.main_lec_code}'" /></td>
				<td align="center" width="20%"><a href="/mooc/viewMainLec.mooc?main_lec_code=${sub_dto.main_lec_code}">${sub_dto.main_lec_subject}(리뷰:${sub_dto.reviewLecCount})</a></td>
				<td align="center"><a href="/mooc/watchLec.mooc?sub_lec_code=${sub_dto.sub_lec_code}">${sub_dto.sub_lec_subject}(관심강의:${sub_dto.likeLectureCount})</a></td>
				<td align="center">${sub_dto.sub_lec_content}</td>
				<td align="center">${sub_dto.u_name}(관심강사:${sub_dto.likeTeacherCount})</td>
				<td align="center"><input type="button" class="btn btn-default" value="미리보기" onclick="myFunction(${sub_dto.ot_link})" />
				</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${subCount==0}">
		<tr><td colspan="6">검색결과가 없습니다.</td></tr>
	</c:if>
</table>

  <script>
function myFunction(i) {
	 cw=screen.availWidth;
	 ch=screen.availHeight;
	 test=window.open('/mooc/watchLec.mooc?sub_lec_code='+i,'_blank','width='+cw+',height='+ch+',resizable=no,scrollbars=yes');
	}
</script>
