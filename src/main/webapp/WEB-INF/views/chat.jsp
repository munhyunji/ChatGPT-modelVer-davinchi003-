<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./inc/header.jsp"%>


<style>
/*대화창*/
.content {
	width: 600px;
	margin: 0 auto;
	height: 500px;
	overflow-y: scroll;
	border-radius: .6em;
	background: #eee;
	box-shadow: 1px 1px gray;
}

.content::-webkit-scrollbar {
	display: none;
}

.line {
	margin-top: 10px;
	display: flex;
}

/*말풍선*/
.mychatbox, .botchatbox {
	padding: 5px;
	max-width: 260px;
	margin-right: 10px;
}

.mySendTime {
	margin-right: 7px;
	font-size: 12px;
	margin-top: 10px;
}

.botSendTime {
	font-size: 12px;
	margin-top: 10px;
}

.me {
	margin-left: auto;
}

.mychatbox {
	position: relative;
	background: #FFEB33;
	border-radius: .4em;
	box-shadow: 1px 1px 2px gray;
}

.mychatbox:after {
	content: '';
	position: absolute;
	right: 0;
	top: 50%;
	width: 0;
	height: 0;
	border: 10px solid transparent;
	border-left-color: #FFEB33;
	border-right: 0;
	border-top: 0;
	margin-top: -13px;
	margin-right: -8px;
}

.botchatbox {
	position: relative;
	background: white;
	border-radius: .4em;
	margin-left: 10px;
	box-shadow: 1px 1px 2px gray;
}

.botchatbox:after {
	content: '';
	position: absolute;
	left: 0;
	top: 50%;
	width: 0;
	height: 0;
	border: 10px solid transparent;
	border-right-color: white;
	border-left: 0;
	border-top: 0;
	margin-top: -13px;
	margin-left: -9px;
}

/*전송*/
.command {
	width: 600px;
	margin: 0px auto 50px auto;
}

.send {
	margin-left: auto;
}

.chatcommand {
	margin: 3px auto;
	background: #eee;
	width: 100%;
	border-radius: .4em;
}

.send {
	margin-left: auto;
}

.gradi {
	  background: linear-gradient(to right top, #861657, #ffa69e);
	  color: transparent;
    -webkit-background-clip: text;
}
</style>

<!-- Services-->
<section class="page-section" id="services">
	<div class="container">
		<div class="text-center">
			<h2 class="section-heading text-uppercase">🤖<br>ChatGPT <span class="gradi">Demo</span></h2>
			<h3 class="section-subheading text-muted">Base on OpenAI
				(Model : text-davinci-003)</h3>
		</div>
		<div class="row text-center">
			<div class="col-md-12">
				<div class="content col-md-12">
					<div class="line">
						<div class="mySendTime me">12:00</div>
						<span class="mychatbox ">안녕 로봇아?</span>
					</div>
					<div class="line">
						<span class="botchatbox">반갑습니다. </span>
						<div class="botSendTime">12:00</div>
					</div>
				</div>
				<div class="command">
					<input class="chatcommand" id="input">
					<!-- <button class="send" id="send">전송</button>	-->
				</div>
				<!-- <h4 class="my-3">E-Commerce</h4>-->
				<p class="text-muted">Lorem ipsum dolor sit amet, consectetur
					adipisicing elit. Minima maxime quam architecto quo inventore harum
					ex magni, dicta impedit.</p>
			</div>
		</div>
	</div>
</section>



</body>
<script type="module">
		
		import { Configuration, OpenAIApi } from 'https://cdn.skypack.dev/openai'
		
		document.querySelector('#input').addEventListener('keyup', (e)=>{
			
		if(e.keyCode === 13) {
			// 나의 말풍선 추가 
			// 템플릿 문자열 : ``으로 문자열을 감싸면 상수를제외한 문자열을 그대로 반환함.
			var text = document.getElementById("input");
			var content = document.querySelector('.content');
			var date = new Date();
			var amPm = date.getHours() < 12 ? "오전 " : "오후 ";
			var time = date.getHours();
			var min = date.getMinutes();
			
			var bubble = `<div class="line"><div class="mySendTime me">`+amPm+time+`:`+min+`</div><span class="mychatbox">`+text.value+`</span></div>`;
			if( text.value != "" ) {
				document.querySelector('.content').insertAdjacentHTML('beforeend', bubble);
				content.scrollTop = content.scrollHeight;
			} else {
				alert("채팅 내용을 작성하세요!");
				text.focus;
			}
			
			const requestOptions = {
				method : 'POST',
				headers: {
				  'Content-Type': 'application/json',
          		  'Authorization': 'Bearer ' + String('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')
				},
				body: JSON.stringify({
					'prompt': text.value,
         			'temperature': 0.1,
         			'max_tokens': 500,
         			'top_p': 1,
         			'frequency_penalty': 0,
        			'presence_penalty': 0.5,
        			'stop': ["\"\"\""],
				})
			  };
				
			  fetch('https://api.openai.com/v1/engines/text-davinci-003/completions', requestOptions)
          		.then(response => response.json())
          		.then(data => {
            		//console.log(data.choices[0].text);
					var botBubble = `<div class="line"><span class="botchatbox">`+data.choices[0].text+`</span><div class="botSendTime">`+amPm+time+`:`+min+`</div></div>`;
			  		content.insertAdjacentHTML('beforeend', botBubble);
					content.scrollTop = content.scrollHeight;
        	  }).catch(err => {
          			console.log("Ran out of tokens for today! Try tomorrow!");
        	  });
			  	

			  //input 초기화
			  text.value = null;
			}
		})
	</script>
</html>