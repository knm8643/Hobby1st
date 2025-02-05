<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hobby1st</title>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <!-- 네이버 로그인스크립트  -->
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
    integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/default.css">
  <link rel="stylesheet" href="/css/header.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/footer.css">
  <link rel="stylesheet" href="/css/login.css">
  <link rel="stylesheet" href="/css/signUp.css">
  <script>
    window.onload = () => {
      let id = '<%=(String)session.getAttribute("mem_id")%>';
      const main_bg_inner_bottom_list = document.querySelector(".main_bg_inner_bottom_list");
      let showMore = document.getElementById("showMore");
      let loginform_btn = document.getElementById("loginform_btn");
      let signupform_btn = document.getElementById("signupform_btn");
      let close_btn = document.getElementById("close_btn");
      let sign_up = document.getElementById("sign_up");

      loginform_btn.onclick = () => {
        let modal_bg = document.querySelector(".modal_bg");
        let loginForm = document.querySelector(".loginForm");
        modal_bg.style.zIndex = 10;
        modal_bg.style.display = "flex";
        loginForm.style.zIndex = 11;
        loginForm.style.display = "flex";
      }
      
      close_btn.onclick = () => {
        let modal_bg = document.querySelector(".modal_bg");
        let loginForm = document.querySelector(".loginForm");
        modal_bg.style.zIndex = -1;
        modal_bg.style.display = "none";
        loginForm.style.zIndex = -1;
        loginForm.style.display = "none";
      }
      
      sign_up.onclick = () => {
    	let modal_bg = document.querySelector(".modal_bg");
        let loginForm = document.querySelector(".loginForm");
        let signUp_wrap = document.querySelector(".signUp_wrap");
        loginForm.style.zIndex = -1;
        loginForm.style.display = "none";  
        signUp_wrap.style.zIndex = 11;
        signUp_wrap.style.display = "flex";
      }
      
      // 캐러셀 슬라이더
      const MOVE_WIDTH = 240;
      let current_point = 0;
      let last_point = MOVE_WIDTH * 5;
      let position = 0;
      let leftBtn = document.getElementById("leftBtn");
      let rightBtn = document.getElementById("rightBtn");
      
      leftBtn.onclick = () => {
        if (current_point > 0) {
    	  current_point -= MOVE_WIDTH;
          position += MOVE_WIDTH;
          main_bg_inner_bottom_list.style.transform = "translateX(" + (position) + "px)";        	
        } 
      }

      rightBtn.onclick = () => {
        if (current_point < last_point) {
    	  current_point += MOVE_WIDTH;
          position -= MOVE_WIDTH;
          main_bg_inner_bottom_list.style.transform = "translateX(" + (position) + "px)";
        }
        
      }
    
      // 더보기 
      let sm_start = 6;
      let sm_end = 10;
      let target = 5;
      let sm_total = 25;
      showMore.onclick = () => {
    	$.ajax({
          url: "/showMore?start=" + (sm_start) + "&end=" + (sm_end),
          type: "get",
          dataType: "json" 
        }).done((res) => {  
          if(res.length > 0 && res.length < 5) {
            target = listCount % 5;
          }
          let div = document.querySelector(".fav_club_list_wrap");
          let div1 = document.createElement("div");
          div1.classList.add("fav_club_list_row");

          for (let i = 0; i < target; i++) {
            let div2 = document.createElement("div");
            div2.classList.add("fav_club_list_item_wrap");
            let div3 = document.createElement("div");
            div3.classList.add("fav_club_list_item");
          
            let div4 = document.createElement("div");
      	    div4.classList.add("badge");
        	div4.id = "theme1";
        	div4.innerHTML = (sm_start + i) + "위";
        	   
            let h3 = document.createElement("h3");
        	      
            let a = document.createElement("a");
    	    a.href = "/clubHouse?cl_id=" + (res[i].cl_id);
    	    a.innerHTML = res[i].cl_name;
    	      
    	    let h5_1 = document.createElement("h5");
    	    h5_1.innerHTML = res[i].cl_boss_name;
    	      
    	    let h5_2 = document.createElement("h5");
    	    h5_2.innerHTML = res[i].cl_local;
    	      
    	    let h5_3 = document.createElement("h5");
    	    h5_3.innerHTML = res[i].cl_desc;
                
        	h3.appendChild(a);
            div3.appendChild(div4);
            div3.appendChild(h3);
            div3.appendChild(h5_1);
            div3.appendChild(h5_2);
            div3.appendChild(h5_3);
            div2.appendChild(div3);
            div1.appendChild(div2);
          }
          div.appendChild(div1);
          sm_start += 5;
          sm_end += target;
  		  sm_total -= target;
          showMore.value = sm_start + "위 ~ " + sm_end + "위 더보기";
          
          if(sm_total < 5) {
            showMore.style.display = "none";
          }
        })
      }  
      
   	  // 찜하기
      document.addEventListener("click", (event) => {
        const classListArray = event.target.classList.value.split(' ');
    	const isHeartButton = classListArray.find((classItem) => classItem === 'fa-heart');
    	if (event.target && isHeartButton) {
    	  event.target.classList.toggle("fas");
    	  event.target.classList.toggle("far");
    	  console.log(event.target.id);
    	  console.log(event);
    	  $.ajax({
              url: "/clubList/clubBoardRec?cl_id=" + event.target.id,
              type: "get",
              dataType: "json" 
          }).done((res) => {
        	  
          });
    	}
      });
      
   	  // 카테고리 클릭 시 슬라이더 리스트 가져오기
   	  const main_bg_inner_top_list_item = document.querySelectorAll(".main_bg_inner_top_list_item");
   	  for(let i = 0; i < main_bg_inner_top_list_item.length; i++) {
   		main_bg_inner_top_list_item[i].onclick = () => {
   		  let cl_category_id = main_bg_inner_top_list_item[i].id;
   		  
   		  $.ajax({
            url: "/selectByCategory?cl_category_id=" + cl_category_id,
            type: "get",
            dataType: "json" 
          }).done((res) => {
      	    
      	    
      	    while (main_bg_inner_bottom_list.hasChildNodes()) {	
      	      main_bg_inner_bottom_list.removeChild(main_bg_inner_bottom_list.firstChild);
      		}
      	    

      	  	if(res.length > 0) {
      	    for(let i = 0; i < res.length; i++) {
      	      let div1 = document.createElement("div");
      	      div1.classList.add("main_bg_inner_bottom_list_item_wrap");
      	      
      	      let div2 = document.createElement("div");
      	      div2.classList.add("main_bg_inner_bottom_list_item");
      	      
      	      let div3 = document.createElement("div");
      	      div3.classList.add("likeBtn");
      	      let icon = document.createElement("i");
      	      if(id != 'null') {
                icon.classList.add("far");
                icon.classList.add("fa-heart");
      	      	<c:forEach var="iList" items="${interestList}">
      	          if(res[i].cl_id == ${iList.cl_id}) {
      	            icon.classList.remove("far");	
      	            icon.classList.add("fas");	
      	          }
      	        </c:forEach>
              }
      	      icon.id = res[i].cl_id;
      	      
      	      let div4 = document.createElement("div");
      	      div4.classList.add("badge");
      	      div4.id = "theme1";
      	      div4.innerHTML = res[i].cl_category_id + " " + (i + 1) +"위";
      	   
      	      let h3 = document.createElement("h3");
      	      
      	      let a = document.createElement("a");
      	      a.href = "/clubHouse?cl_id=" + (res[i].cl_id);
      	      a.innerHTML = res[i].cl_name;
      	      
      	      let h5_1 = document.createElement("h5");
      	      h5_1.innerHTML = res[i].cl_boss_name;
      	      
      	      let h5_2 = document.createElement("h5");
      	      h5_2.innerHTML = res[i].cl_local;
      	      
      	      let h5_3 = document.createElement("h5");
      	      h5_3.innerHTML = res[i].cl_desc;
      	      
      	      h3.appendChild(a);
      	      div3.appendChild(icon);
      	      div2.appendChild(div3);
      	      div2.appendChild(div4);
      	      div2.appendChild(h3);
      	      div2.appendChild(h5_1);
      	      div2.appendChild(h5_2);
      	      div2.appendChild(h5_3);
      	      div1.appendChild(div2);
      	      main_bg_inner_bottom_list.appendChild(div1);
      	    }
      	  	}
      	    main_bg_inner_bottom_list.style.transform = "translateX(" + (current_point + position) + "px)";
      	    current_point = 0;
      	    position = 0;
          });
   		}
   	  }
   	  
      
      /* 네이버 로그인 */ 
      /* const naverLogin = new naver.LoginWithNaverId(
    			{
    				clientId: "lBYZ6xYGSN3wiVHC2ZK4",
    				callbackUrl: "http://localhost/",
    			}
    		);
      
      if (!window._babelPolyfill) {
    	  require("babel-polyfill");
    	  }
        naverLogin.init();
        
        naverLogin.getLoginStatus(function (status) {
            if (status) {        	  
          	  const name=naverLogin.user.getName();
          	  const email=naverLogin.user.getEmail();
          	  const gender=naverLogin.user.getGender();
          	  const mobile=naverLogin.user.getMobile();
              const age=naverLogin.user.getAge();
              const birthyear=naverLogin.user.getBirthyear();
              const birthday=naverLogin.user.getBirthday();
              const nickname=naverLogin.user.getNickName();

               if(age===null||age===undefined ){ 
                   alert("나이를 선택해주세요!");
                   naverLogin.reprompt(); 
                   return  
               }else if(birthday===null||birthday===undefined) {
              	   alert("생년월일을 선택해주세요!");
              	   naverLogin.reprompt();
              	   return
               }else if(name===null||name===undefined) {
                   alert("이름을 선택해주세요!");
                   naverLogin.reprompt(); 
                   return
               }else if(email===null||email===undefined) {
                   alert("이메일을 선택해주세요!");
                   naverLogin.reprompt(); 
                   return
               }else if(mobile===null||mobile===undefined) {
                   alert("전화번호를 선택해주세요!");
                   naverLogin.reprompt(); 
                   return
               }else if(nickname===null||nickname===undefined) {
                   alert("닉네임을 선택해주세요!");
                   naverLogin.reprompt(); 
                   return 
               }else{
                   const message_area=document.getElementById('naver_message');
                   message_area.innerHTML=`
                   <input type=text name=naver_id value=` + nickname + `>
                   <input type=text name=naver_mobile value=` + mobile + `>
                   <input type=text name=naver_email value=` + email + `>
                   <input type=text name=naver_name value=` + name + `>
                   <input type=text name=naver_nickname value=` + nickname + `>
                   <input type=text name=naver_birthyear value=` + birthyear + `>
                   <input type=text name=naver_birthday value=` + birthday + `>
                   <input type=text name=naver_gender value=` + gender + `>
                   `
                   setLoginStatus(); 
               }
            }
          });
        function setLoginStatus(){ 	  
            const button_area=document.getElementById('naver');
            button_area.innerHTML="<button id='naverIdLogin' type='submit'>Naver LOGIN</button>";
     	  
            const logout=document.getElementById('btn_logout');
            logout.addEventListener('click',(e)=>{
                naverLogin.logout();
            });   
        }
        document.getElementById('loginid').onclick = () => {
            var mem_id = document.getElementById('mem_id').value
            var mem_pass = document.getElementById('mem_pass').value
            console.log(mem_id);
            console.log(mem_pass)
            
            location.href = "/member/logind?mem_id="+(mem_id)+"&mem_pass="+(mem_pass);
        } */
        
        /* 회원가입 */
        let signUp_close_btn = document.getElementById("signUp_close_btn");
        let signUpBtn = document.getElementById("signUpBtn");
        let signUp_slideLeft = document.getElementById("signUp_slideLeft");
        let signUp_slideRight = document.getElementById("signUp_slideRight");
        let signUp_container = document.querySelector(".signUp_container");
        let signUp_MOVE_WIDTH = 528;
        let signUp_position = 0;
        
        signupform_btn.onclick = () => {
          let modal_bg = document.querySelector(".modal_bg");
          let signUp_wrap = document.querySelector(".signUp_wrap");
          modal_bg.style.zIndex = 10;
          modal_bg.style.display = "flex";
          signUp_wrap.style.zIndex = 11;
          signUp_wrap.style.display = "flex";
        }
        
        signUp_close_btn.onclick = () => {
          let modal_bg = document.querySelector(".modal_bg");
          let signUp_wrap = document.querySelector(".signUp_wrap");
          modal_bg.style.zIndex = -1;
          modal_bg.style.display = "none";
          signUp_wrap.style.zIndex = -1;
          signUp_wrap.style.display = "none";
        }
        
        let mem_id = document.getElementById("mem_id");
        let mem_id_Result = document.getElementById("mem_id_Result");
        
        let mem_pass = document.getElementById("mem_pass");
        let mem_pw_Result = document.getElementById("mem_pw_Result");
        
        let mem_pass2 = document.getElementById("mem_pass2");
        let mem_pw2_Result = document.getElementById("mem_pw2_Result");
        
        let mem_name = document.getElementById("mem_name");
        let mem_name_Result = document.getElementById("mem_name_Result");
        
        let mem_nickname = document.getElementById("mem_nickname");
        let mem_nickname_Result = document.getElementById("mem_nickname_Result");
        
        let mem_birthday = document.getElementById("mem_birthday");
        let mem_birthday_Result = document.getElementById("mem_birthday_Result");
        
        let mem_phone = document.getElementById("mem_phone");
        let mem_phone_Result = document.getElementById("mem_phone_Result");
        
        let mem_email = document.getElementById("mem_email");
        let mem_email_Result = document.getElementById("mem_email_Result");
        
        let select_gender = document.getElementById("select_gender");
        let mem_gender_Result = document.getElementById("mem_gender_Result");
        
        let mem_address = document.getElementById("mem_address");
        let mem_address_Result = document.getElementById("mem_address_Result");
        
        
         mem_id.onblur = () => {
          if(mem_id.value == "") {
        	mem_id_Result.style.color = "tomato";
            mem_id_Result.innerText = "ID를 입력해 주세요";  
          } else {
            $.ajax({
		      url : "/member/idCheck",
			  data: {id: mem_id.value}
			}).done(function(resp){
		      if(resp == "1") {
		    	mem_id_Result.style.color = "tomato";
		    	mem_id_Result.innerText = "중복된 아이디입니다.";
		    	mem_id.value = ""
			    mem_id.focus();
			  } else if(resp == "0") {
				mem_id_Result.style.color = "forestgreen";
				mem_id_Result.innerText = "사용 가능한 아이디입니다.";    
			  }
			})
          }
        }
        
        mem_id.onkeyup = () => {
          if(mem_id.value != "") {
            mem_id_Result.innerText = "";
          }	  	
        }
        
/*         mem_pass.onblur = () => {
         var passcheck = RegExp(/^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\,.<>\/?]).{8,16}$/);
          if(mem_pass.value == "") {
        	mem_pw_Result.innerText = "패스워드를 입력해 주세요";	  
          }else if(passcheck.test($("#mem_pass").val())) {
              $("#mem_pw_Result").text("");		   
          }else {
			  $("#mem_pass").val("");
              $("#mem_pw_Result").text("8~16자 사이 영문,숫자,특수문자 1개 이상입력")
          }  
        }
        
        mem_pass.onkeyup = () => {
          if(mem_pass.value != "") {
        	mem_pw_Result.innerText = "";  
          }  	
        } */
        
/*         mem_pass2.onblur = () => {
          if(mem_pass2.value == "") {
            mem_pw2_Result.innerText = "패스워드를 한번 더 입력해 주세요";	  
          } else if($("#mem_pass").val() != $("#mem_pass2").val()){
        	  $("#mem_pass").val("")
 	          $("#mem_pw2_Result").text("비밀번호가 일치하지 않습니다.")
          } else if($("#mem_pass").val() == $("#mem_pass2").val()){
	  	      $("#mem_pw2_Result").text("");
          }
        }

        mem_pass2.onkeyup = () => {
          if(mem_pass2.value != "") {
        	  mem_pw2_Result.innerText = "";  
          }  	
        }
        
        mem_name.onblur = () => {
          if(mem_name.value == "") {
        	mem_name_Result.innerText = "2~6자 사이의 한글만 입력해주세요.";	  
          }	
        }

        mem_name.onkeyup = () => {
          if(mem_name.value != "") {
        	mem_name_Result.innerText = "";  
          }  	
        }
        
        mem_nickname.onblur = () => {
          if(mem_nickname.value == "") {
        	mem_nickname_Result.innerText = "닉네임을 입력해 주세요";	  
          }	
        }

        mem_nickname.onkeyup = () => {
          if(mem_nickname.value != "") {
        	mem_nickname_Result.innerText = "";  
          }  	
        } */ 
        
        mem_birthday.onblur = () => {
          if(mem_birthday.value == "") {
        	mem_birthday_Result.innerText = "생일을 입력해 주세요";	  
          }	
        }

        mem_birthday.onkeyup = () => {
          if(mem_birthday.value != "") {
        	mem_birthday_Result.innerText = "";  
          }  	
        }
        
/*         mem_phone.onblur = () => {
          if(mem_phone.value == "") {
        	mem_phone_Result.innerText = "12자 이하 '-' 없이 입력해주세요.";	  
          }	
        }

        mem_phone.onkeyup = () => {
          if(mem_phone.value != "") {
        	mem_phone_Result.innerText = "";  
          }  	
        } */
        
/*         mem_email.onblur = () => {
          if(mem_email.value == "") {
        	mem_email_Result.innerText = "이메일을 입력해 주세요";	  
          }	
        }

        mem_email.onkeyup = () => {
          if(mem_email.value != "") {
        	mem_email_Result.innerText = "";  
          }  	
        } */
        
        select_gender.onblur = () => {
          if(select_gender.options[0].selected) {
        	mem_gender_Result.innerText = "성별을 선택해 주세요";	  
          }	
        }
        
        select_gender.onclick = () => {
          if(select_gender.options[1].selected || select_gender.options[2].selected) {
        	mem_gender_Result.innerText = "";  
          }  	
        }
        
        mem_address.onblur = () => {
          if(mem_address.options[0].selected) {
        	mem_address_Result.innerText = "지역을 선택해 주세요";	  
          }	
        }
        
        mem_address.onclick = () => {
          if(!mem_address.options[0].selected) {
        	mem_address_Result.innerText = "";  
          }  	
        }
        
        
        let signUp_current_point = 0;

        let signUp_end_point = signUp_MOVE_WIDTH * 3;

        if (signUp_current_point == 0) {
          signUp_slideLeft.style.display = "none";
        }

        if (signUp_current_point == signUp_end_point) {
          signUp_slideRight.style.display = "none";
        }

        signUp_slideRight.onclick = () => {
          if (mem_id.value != "" && mem_pass.value != "" && mem_pass2.value != "" && 
              mem_name.value != "" && mem_nickname.value != "" && mem_birthday.value != "" && 
        	  mem_phone.value != "" && mem_email.value != "" && !select_gender.options[0].selected) {
          signUp_current_point += signUp_MOVE_WIDTH;
            
            if (signUp_current_point == signUp_end_point) {
              signUp_slideRight.style.display = "none";
              signUpBtn.style.display = "inline";
              signUp_slideLeft.style.display = "inline";
            } else if (signUp_current_point > 0) {
              signUp_slideLeft.style.display = "inline";
              signUpBtn.style.display = "none";
            }
            
            signUp_position -= signUp_MOVE_WIDTH;
            signUp_container.style.transform = "translateX(" + (signUp_position) + "px)";
          
          } else {
            alert("정보를 모두 입력해 주세요");	  
          }
        }
        
        signUp_slideLeft.onclick = () => {
          signUp_current_point -= signUp_MOVE_WIDTH;
          if (signUp_current_point == 0) {
            signUp_slideLeft.style.display = "none";
            signUp_slideRight.style.display = "inline";
            signUpBtn.style.display = "none";
          } else if (signUp_current_point < signUp_end_point) {
            signUp_slideRight.style.display = "inline";
            signUpBtn.style.display = "none";
          }
          signUp_position += signUp_MOVE_WIDTH;
          signUp_container.style.transform = "translateX(" + (signUp_position) + "px)";
        }

        let city = document.querySelectorAll(".city");
        const cities = [...city];

        let option = document.querySelectorAll("#cl_local option");
        const options = [...option];

        document.addEventListener("change", (e) => {
          for (let i = 0; i < cities.length; i++) {
            if (e.target.value == cities[i].id) {
              cities[i].classList.add("active");
            } else {
              cities[i].classList.remove("active");
            }
          }
        })

        let getRandomNum = (min, max) => {
          min = Math.ceil(min);
          max = Math.floor(max);
          return Math.floor(Math.random() * (max - min + 1)) + min; 
        }

        const previewImage = document.getElementById("preview_img");
        select_gender.addEventListener("change", (e) => {
          if(e.target.id == "select_gender" && e.target.value == "M") {
            previewImage.src = "/images/man" + (getRandomNum(1, 3)) +".png";
          } else if(e.target.id == "select_gender" && e.target.value == "F") {
            previewImage.src = "/images/woman" + (getRandomNum(1, 3)) +".png";
          }
        })

        function readImage(input) {
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = e => {
              previewImage.src = e.target.result;
            }
            reader.readAsDataURL(input.files[0])
          }
        }

        const inputImage = document.getElementById("input-image");
        inputImage.addEventListener("change", e => {
          readImage(e.target)
        });

        signUp_close_btn.onclick = () => {
          let modal_bg = document.querySelector(".modal_bg");
          let signUp_wrap = document.querySelector(".signUp_wrap");
          modal_bg.style.zIndex = -1;
          modal_bg.style.display = "none";
          signUp_wrap.style.zIndex = -1;
          signUp_wrap.style.display = "none";
        }
    }
  </script>
</head>

<body>
  <div class="modal_bg">

  </div>
  <!-- sign_in -->
  <jsp:include page="login.jsp"></jsp:include>
  <div class="wrap">
    <div class="header">
      <div class="header_inner">
        <div class="header_inner_top">
          <div class="logo">
            <a href="/"><img src="/images/LOGO.png"></a>
          </div>
          <ul class="login_list">
            <c:choose>
				 <c:when test="${mem_id !=null }">
               	 <li id="login_id"><b>${mem_id }</b>님 환영합니다</li>
               	 <a href="/member/logout">
                  <li class="login_list_item">로그아웃</li>
                </a>
                <li class="login_list_item" id="loginform_btn" style="display:none">로그인</li>
                <li class="login_list_item" id="signupform_btn" style="display:none">회원가입</li>
              </c:when>
              <c:otherwise>
                <li class="login_list_item" id="loginform_btn">로그인</li>
                <li class="login_list_item" id="signupform_btn">회원가입</li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>
        <div class="header_inner_bottom">
          <ul class="menu_list">
            <a href="/hobby1st"><li class="menu_list_item">Hobby1st</i></li></a>
            <a href="/club"><li class="menu_list_item">동호회</li></a>
            <a href="/myPage"><li class="menu_list_item">마이페이지</li></a>
            <a href="/news"><li class="menu_list_item">NEWS</li></a>
            <a href="/vote"><li class="menu_list_item">VOTE</li></a>
            <!-- <a href="/fullpage"><li class="menu_list_item">Fullpage</li></a> -->
            <c:if test="${admin != null }">
            <a href="/admin"><li class="menu_list_item">admin</li></a>
            </c:if>
          </ul>
        </div>
      </div>
    </div>
    <div class="main_bg">
      <div class="main_bg_top"></div>
      <div class="main_bg_inner_box">
        <div class="main_bg_inner_wrap">
          <div class="main_bg_inner_top">
            <ul class="main_bg_inner_top_list">
              <c:forEach var="clubCategory" items="${ clubCategory}">
                <li class="main_bg_inner_top_list_item" id="${clubCategory.cc_category_name}">#${clubCategory.cc_category_name}</li>
		      </c:forEach>
            </ul>
          </div>
          <div class="main_bg_inner_bottom">
            <div class="arrow" id="right"><i class="fas fa-chevron-right" id="rightBtn"></i></div>
            <div class="arrow" id="left"><i class="fas fa-chevron-left" id="leftBtn"></i></div>
            <div class="main_bg_inner_bottom_list">
              <c:forEach var="clubList" items="${list }" begin="0" end="9" varStatus="status">
                <div class="main_bg_inner_bottom_list_item_wrap">
                  <div class="main_bg_inner_bottom_list_item">
                    <div class="badge" id="theme1">개발 ${status.count }위</div>
                    <h3><a href="/clubHouse?cl_id=${clubList.cl_id }">${clubList.cl_name }</a></h3>
                    <h5>${clubList.cl_boss_name}</h5> 
                    <h5>${clubList.cl_local }</h5>
                    <h5>${clubList.cl_desc }</h5>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </div>
      </div>
      <div class="main_bg_bottom"></div>
    </div>

    <div class="hobby1st_dashboard">
      <div class="hobby1st_dashboard_inner">
        <div class="hobby1st_dashboard_inner_text">
          <span id="dashboard">Hobby1st의 소중한 회원 수 ${memberCount } 명</span>
        </div>
        <div class="hobby1st_dashboard_inner_text">
          <span id="dashboard2">현재 ${clCount }개의 동호회에서 ${clmemCount }명이 함께 하고 있습니다!!</span>
        </div>
      </div>
    </div>

    <c:if test="${mem_id !=null }">
    <!-- VOTE -->
	<div class="vote_preview_title">
      <div class="vote_preview_title_text">
        <h4>VOTE</h4>
      </div>
    </div>
	<div class="vote_preview">
	  <iframe src="/vote/presentVoteList"></iframe>
	</div>
    <!-- VOTE END -->
	</c:if>
	
    <div class="container">
      <div class="fav_club_list_title">
        <div class="fav_club_list_title_text">
          <h4>추천 동호회</h4>
        </div>
      </div>
      <div class="fav_club_list_wrap">
        <div class="fav_club_list_row">
          <c:forEach var="Clt5" items="${ClubListByTop5 }" varStatus="status">
          <div class="fav_club_list_item_wrap">
            <div class="fav_club_list_item">
              <div class="badge" id="theme1">${status.count }위</div>
              <h3><a href="/clubHouse?cl_id=${Clt5.cl_id }">${Clt5.cl_name }</a></h3>
              <h5>${Clt5.cl_boss_name}</h5> 
              <h5>${Clt5.cl_local }</h5>
              <h5>${Clt5.cl_desc }</h5>
            </div>
          </div>
          </c:forEach>
        </div>
      </div>

      <div class="fav_club_list_add_btn">
        <input type="button" value="6위 ~ 10위 더보기" id="showMore">
      </div>
    </div>

    <div class="footer">
      <div class="footer_inner">
        <div class="footer_logo">
          <img src="/images/LOGO.png">
        </div>
        <div class="footer_contents">
          <div class="footer_desc">
            <ul class="footer_desc_list">
              <li class="footer_desc_list_item">Hobby1st 고객센터 02-1234-5678 (평일 09:00~18:00, 주말·공휴일 휴무)</li>
              <li class="footer_desc_list_item">(주)Hobby1st 04540, 서울특별시 중구 남대문로 120, 대일빌딩 2F, 3F</li>
              <li class="footer_desc_list_item">Copyright (c) (주)Hobby1st. 2022 All rights reserved.</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <jsp:include page="signUp.jsp"></jsp:include>
</body>
</html>