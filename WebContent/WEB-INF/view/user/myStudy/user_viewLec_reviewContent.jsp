<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<div class="page-header">
  <h1><small>���� �� �ۼ�</small></h1>
</div>
  <form method="post" action="/mooc/user/user_reviewInsert.mooc" name="review">
  <table width="800" align="center" border="1" border-color="black"/>
  <input type="hidden" name="main_code" value="${view_code}">
  <input type="hidden" name="view_subject" value="${view_subject}">
     <tr>
     <td colspan="5" width="50%" >���� ����
     </td>
   	 <td>�ſ� �׷���(5��)</td><td>�׷���(4��)</td><td>����(3��)</td><td>������(2��)</td><td>�ſ� ������(1��)</td>
  </tr>
  <tr>
     <td colspan="5" width="50%">1.�� ���ǿ� ���� ��ü������ �����Ѵ�.
     </td>
     <td width="10%"><input type="radio" name="a" value='5' checked></td>
     <td width="10%"><input type="radio" name="a" value='4' ></td>
     <td width="10%"><input type="radio" name="a" value='3' ></td>
     <td width="10%"><input type="radio" name="a" value='2' ></td>
     <td width="10%"><input type="radio" name="a" value='1' ></td>
  </tr>
  <tr>
     <td colspan="5" width="50%">2.�������� ������ ���糪 �������� �н��� ������ �Ǿ���.
     </td>
     <td width="10%"><input type="radio" name="b" value='5' checked></td>
     <td width="10%"><input type="radio" name="b" value='4' ></td>
     <td width="10%"><input type="radio" name="b" value='3' ></td>
     <td width="10%"><input type="radio" name="b" value='2' ></td>
     <td width="10%"><input type="radio" name="b" value='1' ></td>
  </tr>
   <tr>
     <td colspan="5" width="50%">3.�������� �л��� �н��ǿ��� �����ϰ� ������ ���� ������Ű���� ����ϼ̴�.
     </td>
     <td width="10%"><input type="radio" name="c" value='5' checked></td>
     <td width="10%"><input type="radio" name="c" value='4' ></td>
     <td width="10%"><input type="radio" name="c" value='3' ></td>
     <td width="10%"><input type="radio" name="c" value='2' ></td>
     <td width="10%"><input type="radio" name="c" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">4.�������� �� ���¿� ���õ� ����� ���İ� ���ظ� ���� �־���.
     </td>
     <td width="10%"><input type="radio" name="d" value='5' checked></td>
     <td width="10%"><input type="radio" name="d" value='4' ></td>
     <td width="10%"><input type="radio" name="d" value='3' ></td>
     <td width="10%"><input type="radio" name="d" value='2' ></td>
     <td width="10%"><input type="radio" name="d" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">5.������ ����� �з��� �н��� ������ �Ǵ� ���̾���. 
     </td>
     <td width="10%"><input type="radio" name="e" value='5' checked></td>
     <td width="10%"><input type="radio" name="e" value='4' ></td>
     <td width="10%"><input type="radio" name="e" value='3' ></td>
     <td width="10%"><input type="radio" name="e" value='2' ></td>
     <td width="10%"><input type="radio" name="e" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">6.���� �� ���¸� ���� ���� ������ �׾Ҵ�.
     </td>
     <td width="10%"><input type="radio" name="f" value='5' checked></td>
     <td width="10%"><input type="radio" name="f" value='4' ></td>
     <td width="10%"><input type="radio" name="f" value='3' ></td>
     <td width="10%"><input type="radio" name="f" value='2' ></td>
     <td width="10%"><input type="radio" name="f" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">7.���� �� ���¸� ���� �������� ��ǥ�� �Ǵ� ���� �ۼ��̳� �������� ���� ��� ���� ������ �����.
     </td>
     <td width="10%"><input type="radio" name="g" value='5' checked></td>
     <td width="10%"><input type="radio" name="g" value='4' ></td>
     <td width="10%"><input type="radio" name="g" value='3' ></td>
     <td width="10%"><input type="radio" name="g" value='2' ></td>
     <td width="10%"><input type="radio" name="g" value='1' ></td>
  </tr>
    <tr>
     <td colspan="5" width="50%">8.���� �ٸ� ����鿡�� �� ������ ������ �����ϰڴ�.
     </td>
     <td width="10%"><input type="radio" name="h" value='5' checked></td>
     <td width="10%"><input type="radio" name="h" value='4' ></td>
     <td width="10%"><input type="radio" name="h" value='3' ></td>
     <td width="10%"><input type="radio" name="h" value='2' ></td>
     <td width="10%"><input type="radio" name="h" value='1' ></td>
  </tr>
  <tr height="300">
     <td rowspan="12" colspan="2">�����ϰ� ���� ���� �ִٸ�?</td>
    <td rowspan="12" colspan="8">
    <textarea  rows="8" cols="50" name="content1"></textarea>
    </td>
 </tr>
 </table><br />
 <p align="center">
 <input type="submit" value="����">
 </p>
 </form> 
