package _dto;

import java.util.ArrayList;
import java.util.List;

public class pageAction {
	private int currentPage;
	private int startRow ;
	private int endRow;
	private int count;
	private int pageSize;
	public List pageList(String pageNum,List AllList,int pageSize){
		if(pageNum==null){pageNum="1";}
		this.pageSize =pageSize;//�� �������� ���� ����
        currentPage = Integer.parseInt(pageNum);
        startRow = (currentPage - 1) * pageSize ;//�� �������� ���۱� ��ȣ
        endRow = currentPage * pageSize-1;//�� �������� ������ �۹�ȣ
        count = AllList.size();
        
        if(count<endRow){ 
        	endRow=count;
        }
       List list=new ArrayList(endRow-startRow);
       if (count > 0) {
        	while(endRow>startRow){
        		list.add(AllList.get(startRow));
        		startRow++;
        	}
       }
       if(count>endRow){
    	   list.add(AllList.get(startRow));
       }
       return list;
	}
	public int current(){
		return currentPage;
	}
	public int size(){
		return pageSize;
	}
	public int count(){
		return count;
	}

}
