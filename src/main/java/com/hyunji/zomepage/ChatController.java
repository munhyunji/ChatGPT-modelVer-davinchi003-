package com.hyunji.zomepage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

	@RequestMapping(value="/chat")
	public String Chat() {
		System.out.println("ChatController 실행");
		
		return "chat";
	}
}
