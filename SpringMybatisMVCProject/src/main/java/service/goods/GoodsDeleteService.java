package service.goods;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import model.AuthInfo;
import model.GoodsDTO;
import repository.GoodsRepository;

@Service
public class GoodsDeleteService {
	@Autowired
	GoodsRepository goodsRepository; 
	public void goodsDelete(String goodsNum, HttpSession session) {
		AuthInfo authInfo=(AuthInfo) session.getAttribute("authInfo");
		String userId=authInfo.getUserId();
		GoodsDTO dto=new GoodsDTO();
		dto.setGoodsNum(goodsNum);
		dto.setUserId(userId);
		// 파일정보 가져오기 위해서
		dto=goodsRepository.getGoodsList(dto).get(0);
		Integer i=goodsRepository.goodsDelete(dto);
		if (i>=1) {
			String path="WEB-INF/view/goodsView/upload";
			String filePath=session.getServletContext().getRealPath(path);
			File file=null;
			String [] files=dto.getGoodsImage().split("`");
			for (String fileName : files) {
				file=new File(filePath+"/"+fileName);
				if (file.exists()) {
					file.delete();
				}else {
					System.out.println(filePath+"/"+fileName);
				}
			}
			
		}
		
	}
}
