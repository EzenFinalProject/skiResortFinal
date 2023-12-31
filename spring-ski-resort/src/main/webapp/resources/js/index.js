let Eventslides = document.getElementById("slides").innerHTML;
makeSlides();

/**이벤트 슬라이드 만들기*/
function makeSlides() {
  Eventslides = "";
  for (let i = 1; i <= 5; i++) {
    Eventslides += `<li class="event-li"><div class="event-item-box" id="event-item-box${i}"> <div class="event-image-box"  id="event-image-box${i}"></div><div  class="event-filter-box"><div class="event-content-box" id="event-content-box${i}">이벤트 1</div><p id="event-content${i}" class="event-content"><div></div><span id="event-dia${i}" class="diamond event-dia"><i
    class="bi bi-chevron-right "></i> </span></li>`;
  }


  document.getElementById("slides").innerHTML = Eventslides;
}



//공지 두 개 받아오기
async function getTwoNotice(){
    try {
        const url = "/notice/getTwoNotice";
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}
//공지 화면에 뿌리기
   getTwoNotice().then(notice =>{
     if(notice!=undefined){
       for(let i = 0; i<notice.length; i++){     
        
         let originalDate = notice[i].noticeRegAt;
         originalDate = new Date(originalDate);
         /**   년, 월, 일 추출*/
         let year = originalDate.getFullYear();
         let month = String(originalDate.getMonth() + 1).padStart(2, '0');  // 월은 0부터 시작하므로 +1, 두 자리로 패딩
         let day = String(originalDate.getDate()).padStart(2, '0');  // 두 자리로 패딩
         // 포맷팅된 날짜
         let formattedDate = `${year}-${month}-${day}`;
       document.getElementById('notice').innerHTML+= '<ul><li><span class="notice-reg">'+formattedDate+'</span><a class="notice-title" href="/notice/detail?noticeNum='+notice[i].noticeNum+'">'+notice[i].noticeTitle+'</a></li></ul>'        
       }}
   });
//*이벤트 리스트 5개 받아오기 */
async function getFiveEvent(){
    try {
        const url = "/notice/getFiveEvent";
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}
   

  //이벤트 슬라이드에 이미지와 내용 추가
     getFiveEvent().then(events => {
      for (let i = 0; i < events.length; i++) {
          let EventImageBoxes = document.querySelectorAll("#event-image-box" + (i + 1));
          let EventContentBoxes = document.querySelectorAll("#event-content-box" + (i + 1));
          let EventContent = document.querySelectorAll("#event-content" + (i + 1));
          let Eventdias = document.querySelectorAll("#event-dia" + (i + 1));
      
          Eventdias.forEach(function (Eventdia) {
            Eventdia.onclick = function () {
              moveEventSite(events[i].noticeNum);
          };
        });
          EventImageBoxes.forEach(function (EventImageBox) {
              EventImageBox.style.backgroundImage = "url('" + events[i].noticeImageUrl + "')";
              EventImageBox.onclick = function () {
                moveEventSite(events[i].noticeNum);
            };
          });
          EventContentBoxes.forEach(function (EventContentBox) {
            EventContentBox.innerHTML =events[i].noticeTitle; 
          });
          EventContent.forEach(function (EventContent) {
            EventContent.innerText =events[i].noticeContent; 
          });


        }})



      
/**이벤트 페이지 이동 이벤트 */
  function moveEventSite(num){
    location.href = "/notice/detail?noticeNum="+num;
 }
    

  document.addEventListener("DOMContentLoaded", function () {
        var ytLandscape = document.getElementById("ytLandscape");
        var wrapper = document.getElementById("wrapper");

        var initialWrapperPosition = window.innerHeight;

        wrapper.style.top = initialWrapperPosition + "px";

        function updateWrapperPosition() {
            var ytLandscapeRect = ytLandscape.getBoundingClientRect();

            if (ytLandscapeRect.bottom <= window.innerHeight) {
                wrapper.style.top = ytLandscapeRect.bottom + "px";
            } else {
                wrapper.style.top = initialWrapperPosition + "px";
            }
        }

        window.addEventListener("resize", updateWrapperPosition);
        window.addEventListener("scroll", updateWrapperPosition);
    });
    
//이벤트화면
let slides = document.querySelector(".slides"),
  slide = document.querySelectorAll(".slides li"),
  currentIdx = 0,
  slideCount = slide.length,
  slideWidth = 300,
  slideMargin = 30,
  prevBtn = document.querySelector(".prev"),
  nextBtn = document.querySelector(".next");

makeClone();
/** 슬라이드 클론 만들기 */
function makeClone() {
  for (let i = 0; i < slideCount; i++) {
    let cloneSlide = slide[i].cloneNode(true);
    cloneSlide.classList.add("clone");
    slides.appendChild(cloneSlide);
  }
  for (let i = slideCount - 1; i >= 0; i--) {
    let cloneSlide = slide[i].cloneNode(true);
    cloneSlide.classList.add("clone");
    slides.prepend(cloneSlide);
  }

  updateWidth();
  setinit();
  setTimeout(function () {
    slides.classList.add("animated");
  }, 100);
}

function updateWidth() {
  let currentSlides = document.querySelectorAll(".slides li");
  let newSlideCount = currentSlides.length;
  // 가운데 정렬
  let centerOffset = ((slideWidth + slideMargin) * slideCount - slideMargin) / 2;
  let centerTranslateX = centerOffset - (currentIdx * (slideWidth + slideMargin));
  slides.style.transform = "translateX(" + centerTranslateX + "px)";

  let newWidth =
    (slideWidth + slideMargin) * newSlideCount - slideMargin + "px";
  slides.style.width = newWidth;
  moveSlide(currentIdx - 1);



}

function setinit() {
  let TranslateValue = -(slideWidth + slideMargin) * slideCount;
  slides.style.transform = "translateX(" + TranslateValue + "px)";
}


//연타방지
function clickdeilay(){
  nextBtn.style.pointerEvents = "none";
  prevBtn.style.pointerEvents = "none";
  setTimeout(function () {
    nextBtn.style.pointerEvents = "auto";
    prevBtn.style.pointerEvents = "auto";
  }, 1000);
}

nextBtn.addEventListener("click", function () {
  clickdeilay();
  moveSlide(currentIdx + 1);
});

prevBtn.addEventListener("click", function () {
  clickdeilay();
  moveSlide(currentIdx - 1);

});

function moveSlide(num) {
  slides.style.left = -num * (slideWidth + slideMargin) + "px";
  currentIdx = num;
  
	
  if (currentIdx == slideCount || currentIdx == -slideCount) {
    setTimeout(function () {
      slides.classList.remove("animated");
      slides.style.left = "0px";
      currentIdx = 0;
    
    }, 500);
    setTimeout(function () {
      slides.classList.add("animated");
    }, 600);
  }
}

/** 뉴스 슬라이드 버튼 */
function newsSlideBtnEvent(num){
  let translate = (num-1)* -25;
  document.getElementById("new_topic_slides").style.transform= `translateX(${translate}%)`;

  // NodeList를 배열로 변환하여 각 요소에 접근
  let newsTopicBtns = document.querySelectorAll(".news_topic_btn");
  newsTopicBtns.forEach((btn, index) => {
    btn.style.backgroundColor = index + 1 === num ? 'white' : 'transparent';
  });

}
