package user;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

import org.apache.poi.hslf.usermodel.HSLFSlide;
import org.apache.poi.hslf.usermodel.HSLFSlideShow;
import org.apache.poi.sl.usermodel.Slide;
import org.apache.poi.sl.usermodel.SlideShow;



public class PPTChange {
	//�������ϰ��
	private String pptFile;
	private String cvtImgFile;
	
	public PPTChange(String pptFile, String cvtImgFile) {
		this.pptFile = pptFile;
		this.cvtImgFile = cvtImgFile;
	}
	/**
	 * �̹��� ��ȯ ����
	 * @throws IOException
	 */
	public int convter(String code) throws IOException {
		// PPT����
		FileInputStream is = new FileInputStream(pptFile);
	    HSLFSlideShow ppt = new HSLFSlideShow(is);
	    int pageSize=1;
	    is.close();

	    Dimension pgsize = ppt.getPageSize();

	    int idx = 1;
	    for (HSLFSlide slide : ppt.getSlides()) {

	        BufferedImage img = new BufferedImage(pgsize.width, pgsize.height, BufferedImage.TYPE_INT_RGB);
	        Graphics2D graphics = img.createGraphics();
	        
	        
	        graphics.setPaint(Color.white);
	        graphics.fill(new Rectangle2D.Float(0, 0, pgsize.width, pgsize.height));//����ũ�� ����

	        //�̹������Ϻ�ȯ
	        slide.draw(graphics);

	        // save the output
	        FileOutputStream out = new FileOutputStream(cvtImgFile+"Lecture"+code+"_"+ idx + ".png"); //�������ϰ��
	        javax.imageio.ImageIO.write(img, "png", out);
	        out.close();
	        pageSize=idx;
	        idx++;
	    }
	    return pageSize;
	}

}
