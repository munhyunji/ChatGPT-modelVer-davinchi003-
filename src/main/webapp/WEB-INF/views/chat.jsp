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
	background: #20212A;
	box-shadow: 0 0 5px gray;
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
	max-width: 300px;
	margin-right: 10px;
	font-family: 'Noto Serif KR', serif;
	color: white;
}

.mySendTime {
	margin-right: 7px;
	font-size: 12px;
	color: white;
	margin-top: 10px;
}

.botSendTime {
	font-size: 12px;
	margin-top: 10px;
	color: white;
}

.me {
	margin-left: auto;
}

.mychatbox {
	position: relative;
	/*background: #FFEB33;*/
	border-radius: .4em;
	/*box-shadow: 1px 1px 2px gray;*/
}

/*.mychatbox:after {
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
}*/

.botchatbox {
	position: relative;
	/*background: white;*/
	border-radius: .4em;
	margin-left: 10px;
	/*display: none;*/
}

/*.botchatbox:after {
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
}*/

.robotface {
	margin: 0 5px;
}

.typing {  
/*position: absolute;*/ 
  display: inline-block; 
  animation-name: cursor; 
  animation-duration: 1.0s; 
  animation-iteration-count: infinite;
  height: 20px;
 } 
 @keyframes cursor{ 
  0%{border-right: 1px solid #fff} 
  50%{border-right: 1px solid #000} 
  100%{border-right: 1px solid #fff} 
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
	  background: linear-gradient(to right, #00CED1, #3CB371);
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
						<!-- <div class="mySendTime me">12:00</div> -->
						<span class="mychatbox me">안녕 로봇아?</span>
					</div>
					<div class="line">
						<span class="robotface">🤖</span>
						<span class="botchatbox">반갑습니다. </span>
						<!-- <p class="typing"></p>-->
						<!--<div class="botSendTime">12:00</div>-->
					</div>
				</div>
				<div class="command">
					<input class="chatcommand" id="input" placeholder="Say Something..">
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
			
			var bubble = `<div class="line"><span class="mychatbox me">`+text.value+`</span></div>`;
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
					//API key 입력 
          		  'Authorization': 'Bearer ' + String('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')
				},
				body: JSON.stringify({
					'prompt': text.value,
         			'temperature': 0.8,
         			'max_tokens': 256,
         			'top_p': 1,
         			'frequency_penalty': 0,
        			'presence_penalty': 0.5,
        			'stop': ["\"\"\""],
				})
			  };
				
			  fetch('https://api.openai.com/v1/engines/text-davinci-003/completions', requestOptions)
          		.then(response => response.json())
          		.then(data => {
            		console.log(data.choices[0].text);
					document.querySelector('.content').insertAdjacentHTML('beforeend', `<div class="line"><span class="botchatbox">`+data.choices[0].text+`</span></div>`);

					content.scrollTop = content.scrollHeight;
        	  }).catch(err => {
          			//console.log("Ran out of tokens for today! Try tomorrow!");
        	  });
			  	

			  //input 초기화
			  text.value = null;
			}
		})
	</script>
</html>