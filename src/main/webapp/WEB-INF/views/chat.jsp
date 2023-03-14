<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./inc/header.jsp" %>


	<style>
		.content { width: 600px; border: 1px solid black; margin:0 auto; height: 300px; overflow-y: scroll;}	
		.content::-webkit-scrollbar { display:none;}	
		.line { margin-top : 10px; display: flex;}
		.chatbox { background: #eee; padding: 5px; max-width: 200px;}
		.chatcommand { background : #eee; padding 5px; width: 520px; }
		.send { margin-left : auto;}
		.mySendTime { margin-left : auto;}
		.me { margin-left: auto;}
		.chatTitle { margin:200px 50% 50px 50%;}
		.command { width: 600px; border: 1px solid black; margin:0px auto 50px auto;}
	</style>
	
 	<h3 class="chatTitle">Talk with Chat Ai</h3>
 	<div class="content">
 		
 		<div class="line">
 			<div class="mySendTime me">
 				12:00
 			</div>
 			<span class="chatbox ">안녕 로봇아?</span>
 		</div>
 		<div class="line">
 			<span class="chatbox">반갑습니다. </span>
 		</div>
 	</div>
 	<div class="command">
	 	<input class="chatcommand" id="input">
	 	<button id="send">전송</button>
 	</div>
 		
</body>
	<script type="module">
		import { Configuration, OpenAIApi } from 'https://cdn.skypack.dev/openai'
		
		document.querySelector('#send').addEventListener('click', function(){
			//나의 말풍선 추가 
			// 템플릿 문자열 : ``으로 문자열을 감싸면 상수를제외한 문자열을 그대로 반환함.
			var bubble = `<div class="line"><div class="mySendTime me">12:00</div><span class="chatbox">`+document.getElementById('input').value+`</span></div>`;
			
			document.querySelector('.content').insertAdjacentHTML('beforeend', bubble);
			document.getElementById('input').value = null;
			
			
		})
	</script>
</html>