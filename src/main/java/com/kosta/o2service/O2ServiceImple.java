package com.kosta.o2service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kosta.o2dao.O2WriteDAO;
import com.kosta.o2dto.O2DongComDTO;
import com.kosta.o2dto.O2MainBoardDTO;
import com.kosta.o2dto.O2WriteBoardDTO;

@Service
public class O2ServiceImple implements O2Service {
	@Resource(name = "o2WriteDAO")
	private O2WriteDAO dao;
	
	@Autowired
	private JavaMailSender javamailSender;
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javamailSender = javaMailSender;
	}

	@Override
	public void twriteinsert(O2WriteBoardDTO dto) {

		dao.twriteinsert(dto);
	}

	@Override
	public O2WriteBoardDTO twritedetail(int no) {
		
		return dao.twritedetail(no);
	}

	@Override
	public int sellCount(String search, String searchtxt) {
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("search", search);
		hm.put("searchtxt", searchtxt);
		int result = dao.sellCount(hm);
		return result;
	}

	@Override
	public List<O2MainBoardDTO> sellList(String search, String searchtxt, int startRow, int pageSize) {
			
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("search", search);
			hm.put("searchtxt", searchtxt);
			hm.put("startRow", startRow);
			hm.put("pageSize", pageSize);
					
			return dao.sellList(hm);
	}

	@Override
	public int dealCount(String search, String searchtxt) {
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("search", search);
		hm.put("searchtxt", searchtxt);
		return dao.dealCount(hm);
		
	}

	@Override
	public List<O2MainBoardDTO> dealList(String search, String searchtxt, int startRow, int pageSize) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("search", search);
		hm.put("searchtxt", searchtxt);
		hm.put("startRow", startRow);
		hm.put("pageSize", pageSize);
				
		return dao.dealList(hm);
	}
	
	@Override
	public void searchSellData(String search, String searchtxt) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("search", search);
		hm.put("searchtxt", searchtxt);

		//??????????????? ???????????? ??????
	    List<String> category = dao.searchSellCount(hm);
	    
	    //db??? ???????????? ??????
	    if(category.isEmpty() == false)
	    	dao.addSearchData(category);
	}

	@Override
	public void searchDealData(String search, String searchtxt) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("search", search);
		hm.put("searchtxt", searchtxt);

		//??????????????? ???????????? ??????
	    List<String> category = dao.searchDealCount(hm);
	    
	    //db??? ???????????? ??????
	    if(category.isEmpty() == false)
	    	dao.addSearchData(category);	
	}

	@Override
	public List<String> getTopSearch() {
		return dao.getTopSearch();
	}

	@Override
	public List<O2WriteBoardDTO> maillist() {
		// TODO Auto-generated method stub
		return dao.maillist();
	}

	@Override
	public String getmail(String user_id) {
		// TODO Auto-generated method stub
		return dao.getmail(user_id);
	}

	@Override
	public void dealmail(String getmail, String title) {
		// TODO Auto-generated method stub
		MimeMessage message = javamailSender.createMimeMessage();
		try
		{
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"UTF-8");
			helper.setSubject("???????????? ???????????? ???????????????.");
			helper.setText("????????? '"+title+"' ????????? ?????????????????????. ???????????? ????????? ???????????????!",true);
			helper.setFrom("02o252@naver.com");
			helper.setTo(getmail);
			javamailSender.send(message);
			
		}catch(MessagingException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<O2DongComDTO> cmtyList(String search, String searchtxt, int startRow, int pageSize) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("search", search);
		hm.put("searchtxt", searchtxt);
		hm.put("startRow", startRow);
		hm.put("pageSize", pageSize);
				
		return dao.cmtyList(hm);
	}
	
	
	

	
	

	
}
