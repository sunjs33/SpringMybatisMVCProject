package model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GoodsDTO {
	String goodsNum;
	String userId;
	String goodsName;
	String goodsContent;
	String goodsImage;
	Long readCount;
	String ipAddr;
	Long goodsPrice;
	Timestamp goodsRegister;
	
	StartEndPageDTO startEndPageDTO;
	
}
