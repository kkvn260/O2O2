package com.o2.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kosta.o2service.O2ServiceOther;

import lombok.extern.java.Log;

@Log
@Component
public class SearchFilter {

	@Autowired
	O2ServiceOther serviceOther;

	//12시간마다 하루 전 검색데이터들 삭제
	@Scheduled(cron = "0 0 0/12 * * ")
	public void removeSearch() {
		log.warning("removeSearchData.............");
		serviceOther.removeSearchData();
	}
}