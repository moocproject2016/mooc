<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<div class="page-header">
  <h1><small>강의 평가 작성</small></h1>
</div>
  <form method="post" action="/mooc/user/user_reviewInsert.mooc" name="review">
  <table width="800" align="center" border="1" border-color="black"/>
  <input type="hidden" name="main_code" value="${view_code}">
  <input type="hidden" name="view_subject" value="${view_subject}">
     <tr>
     <td colspan="5" width="50%" >질문 내용
     </td>
   	 <td>매우 그렇다(5점)</td><td>그렇다(4점)</td><td>보통(3점)</td><td>부적절(2점)</td><td>매우 부적절(1점)</td>
  </tr>
  <tr>
     <td colspan="5" width="50%">1.본 강의에 대해 전체적으로 만족한다.
     </td>
     <td width="10%"><input type="radio" name="a" value='5' checked></td>
     <td width="10%"><input type="radio" name="a" value='4' ></td>
     <td width="10%"><input type="radio" name="a" value='3' ></td>
     <td width="10%"><input type="radio" name="a" value='2' ></td>
     <td width="10%"><input type="radio" name="a" value='1' ></td>
  </tr>
  <tr>
     <td colspan="5" width="50%">2.교수님이 선택한 교재나 참고문헌은 학습에 도움이 되었다.
     </td>
     <td width="10%"><input type="radio" name="b" value='5' checked></td>
     <td width="10%"><input type="radio" name="b" value='4' ></td>
     <td width="10%"><input type="radio" name="b" value='3' ></td>
     <td width="10%"><input type="radio" name="b" value='2' ></td>
     <td width="10%"><input type="radio" name="b" value='1' ></td>
  </tr>
   <tr>
     <td colspan="5" width="50%">3.교수님은 학생의 학습의욕을 고취하고 수업에 적극 참여시키려고 노력하셨다.
     </td>
     <td width="10%"><input type="radio" name="c" value='5' checked></td>
     <td width="10%"><input type="radio" name="c" value='4' ></td>
     <td width="10%"><input type="radio" name="c" value='3' ></td>
     <td width="10%"><input type="radio" name="c" value='2' ></td>
     <td width="10%"><input type="radio" name="c" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">4.교수님은 본 강좌와 관련된 충분한 지식과 이해를 갖고 있었다.
     </td>
     <td width="10%"><input type="radio" name="d" value='5' checked></td>
     <td width="10%"><input type="radio" name="d" value='4' ></td>
     <td width="10%"><input type="radio" name="d" value='3' ></td>
     <td width="10%"><input type="radio" name="d" value='2' ></td>
     <td width="10%"><input type="radio" name="d" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">5.수업의 내용과 분량은 학습에 도움이 되는 것이었다. 
     </td>
     <td width="10%"><input type="radio" name="e" value='5' checked></td>
     <td width="10%"><input type="radio" name="e" value='4' ></td>
     <td width="10%"><input type="radio" name="e" value='3' ></td>
     <td width="10%"><input type="radio" name="e" value='2' ></td>
     <td width="10%"><input type="radio" name="e" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">6.나는 이 강좌를 통해 많은 지식을 쌓았다.
     </td>
     <td width="10%"><input type="radio" name="f" value='5' checked></td>
     <td width="10%"><input type="radio" name="f" value='4' ></td>
     <td width="10%"><input type="radio" name="f" value='3' ></td>
     <td width="10%"><input type="radio" name="f" value='2' ></td>
     <td width="10%"><input type="radio" name="f" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">7.나는 이 강좌를 통해 논리전개나 발표력 또는 보고서 작성이나 문장기술력 등의 향상에 많은 도움을 얻었다.
     </td>
     <td width="10%"><input type="radio" name="g" value='5' checked></td>
     <td width="10%"><input type="radio" name="g" value='4' ></td>
     <td width="10%"><input type="radio" name="g" value='3' ></td>
     <td width="10%"><input type="radio" name="g" value='2' ></td>
     <td width="10%"><input type="radio" name="g" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">8.나는 다른 사람들에게 이 강좌의 수강을 권유하겠다.
     </td>
     <td width="10%"><input type="radio" name="h" value='5' checked></td>
     <td width="10%"><input type="radio" name="h" value='4' ></td>
     <td width="10%"><input type="radio" name="h" value='3' ></td>
     <td width="10%"><input type="radio" name="h" value='2' ></td>
     <td width="10%"><input type="radio" name="h" value='1' ></td>
  </tr>
  <tr height="300">
     <td rowspan="12" colspan="2">건의하고 싶은 말이 있다면?</td>
    <td rowspan="12" colspan="8">
    <textarea  rows="8" cols="50" name="content1"></textarea>
    </td>
 </tr>
 </table><br />
 <p align="center">
 <input type="submit" value="제출">
 </p>
 </form> 
