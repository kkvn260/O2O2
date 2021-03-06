package com.kosta.o2dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
public class O2QnaBoardDTO {
	
	private int qnano;
	private String user_id;
	private String title;
	private String content;
	private String category;
	private String writedate;
}
