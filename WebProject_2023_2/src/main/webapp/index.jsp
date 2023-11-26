<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>  
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> 


        <title>Document</title>
    </head>

    <body>
        <div id="container">
            <div id="side_left">

            </div>
            <div id="mid_content">
                <div id="day_info">
                    <p style="font-size: 40px;">4 Day</p>
                    <button id="next_day_button">다음날</button>
                    
                </div>
                <div id="heart_content">
                    <div id="heart_gauge" style="margin: 0 auto;">
                        <div id="gauge-fill" style="width: 55%;"></div>
                    </div>
                    <i class="fa-solid fa-heart fa-2xl" style="color: #ff7575; margin: auto;"></i>
                </div>
                <div id="plant_area">
                    <div id="move_left_plant"><i class="fa-solid fa-chevron-left fa-xl"></i></div>
                    <div id="plant">
                        <img src="img/plant.png" />
                    </div>
                    <div id="move_right_plant"><i class="fa-solid fa-chevron-right  fa-xl"></i></div>
                </div>
                <div id="action_area">
                    <div class="buttons_container">
                        <button class="action_button">물주기</button>
                        <button class="action_button">비료주기</button>
                        <button class="action_button">말하기</button>
                          
                    </div>
                    <div class="input_container">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="식물에게 말을 걸어봐요!" aria-label="Recipient's username" aria-describedby="button-addon2">
                            <button class="btn btn-outline-secondary" type="button" id="button-addon2">입력</button>
                          </div>
                        
                    </div>
                </div>

            </div>

            <div id="side_right">
                <div id="side_right_box">
                    
                    <div class="dropdown">

                        <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <i id="user_icon" class="fa-solid fa-user"></i>이채원님
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="#">계정 설정</a></li>
                            <li><a class="dropdown-item" href="#">도움말</a></li>
                            <li><a class="dropdown-item" href="#">관리자 메뉴</a></li>
                            <li><a class="dropdown-item" href="#">로그아웃</a></li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    </body>

    </html>

    <style>
        @font-face {
            font-family: 'omyu_pretty';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/omyu_pretty.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }

        html,
        body {
            font-family: 'omyu_pretty';
            font-size: larger;
            height: 100%;
            /* 화면 전체 높이로 설정 */
            margin: 0;
            /* 기본 마진 제거 */
            padding: 0;
            /* 기본 패딩 제거 */
            overflow: hidden;
        }

        #container {
            display: flex;
            justify-content: center;
            align-items: stretch;
            height: 100%;
            /* 화면 전체 높이로 설정 */
            width: 80%;
            margin: 0 auto;
            /* 상하 마진을 0으로 설정 */
        }

        #heart_content {
            display: flex;
            padding: 0px 100px;
        }

        #day_info {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 10%;
            /* 적절한 높이 설정 필요 */
        }

        #next_day_button {
            position: absolute;
            top: 50%;
            /* 수직 중앙 정렬 */
            right: 0;
            /* 오른쪽 정렬 */
            margin-right: 200px;
            transform: translateY(-50%);
            /* 버튼이 정확한 중앙에 위치하도록 조정 */
            font-size: 30px;
            font-family: 'omyu_pretty';
            border: 2px solid gray;
            border-radius: 20px;
            padding: 10px 20px;
            background-color: white;
        }

        #action_area {
            width: 70%;
            margin: 10% auto;
        }

        .buttons_container {
            display: flex;
            justify-content: center;
            /* 버튼을 가운데 정렬 */
        }

        .input_container {
            width: 100%;
            /* input의 너비를 컨테이너의 100%로 설정 */
            margin-top: 10px;
            /* 버튼과 input 사이의 간격 */
        }

        .action_button {
            margin: 0 auto;
            flex: 1;
            /* 모든 버튼에 동일한 크기 할당 */
            font-size: 30px;
            font-family: 'omyu_pretty';
            border: 2px solid gray;
            border-radius: 20px;
            padding: 10px 20px;
            margin: 0 5px;
            /* 버튼 사이 간격 */
            background-color: white;
        }

        #action_input {
            font-family: 'omyu_pretty';
            width: 100%;
            height: 30px;
            font-size: 25px;
            padding: 10px 20px;
        }

        #side_left,
        #mid_content,
        #side_right {
            margin: 5px;
            height: calc(100% - 10px);
            /* 상하 마진 고려하여 높이 조정 */
        }

        #side_left {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            /* 버튼들을 맨 아래로 위치시킴 */
        }

        #mid_content {
            flex: 5;
        }

        #side_right {
            flex: 1;
        }

        #side_right_box {
            margin: 5px;
        }

        #user_icon {
            margin-right: 10px;
        }

        #down_icon {
            margin-left: 10px;
        }

        /* 하트 게이지 스타일링 */
        #heart_gauge {
            width: 80%;
            /* 전체 게이지 바의 폭 */
            background-color: #ffffff;
            /* 게이지 바의 배경색 */
            border-radius: 10px;
            /* 둥근 모서리 */
            overflow: hidden;
            /* 내부 내용이 바깥으로 넘치지 않도록 함 */
            border: 1px solid grey;
            padding: 5px;
        }

        #gauge-fill {
            height: 40px;
            /* 게이지 높이 */
            background-color: #f97178;
            /* 채워진 게이지의 색상 */
            border-radius: 10px;
            /* 둥근 모서리 */
            transition: width 0.5s ease-in-out;
            /* 부드러운 전환 효과 */

        }

        #plant_area {
            display: flex;
        }

        #move_left_plant,
        #move_right_plant {
            width: 20%;
            display: flex;
            justify-content: center;
            /* 아이콘을 div의 중앙에 정렬 */
            align-items: center;
            /* 아이콘을 수직 중앙에 정렬 */
        }

        #plant {
            margin-top: 50px;
            width: 60%;
            display: flex;
            justify-content: center;
            /* 이미지를 div의 중앙에 정렬 */
            align-items: center;
            /* 이미지를 수직 중앙에 정렬 */
        }

    
    </style>