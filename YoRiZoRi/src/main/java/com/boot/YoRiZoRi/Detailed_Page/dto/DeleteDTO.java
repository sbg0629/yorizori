package com.boot.YoRiZoRi.Detailed_Page.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeleteDTO {
	private int recipe_Id;
	private int review_Id;
	private int comment_Id;
	private int member_Id;
}
