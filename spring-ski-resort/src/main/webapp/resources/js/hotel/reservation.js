//할인율 계산 (원금-coupon_int)-(원금*coupon_rate/100)-(원금*등급할인율/100)
let roomprice;
let StayDate;

document.getElementById("payBtn").addEventListener('click', () => {
    let hotelReservePeople = document.getElementById('hotelReservePeople').value;
    let hotelReserveStayStart = document.getElementById('hotelReserveStayStart').value;
    let hotelReserveStayEnd = document.getElementById('hotelReserveStayEnd').value;
    if (memberEmail == "") {
        alert("로그인 후 이용해주세요");
        location.href = "/member/login";
    }
    else if (hotelReservePeople == "") {
        alert("인원을 선택해주세요");
    } else if (hotelReserveStayStart == "") {
        alert("정확한 날짜를 선택해주세요");
    }
    else {
        document.getElementById("innerbox").style.display = "block";
        document.getElementById("box").style.opacity = 0;
    }


})

document.getElementById("closeBtn").addEventListener('click', () => {

    location.reload();
})

function updateCustomText(dateRange, resultId) {
    var startDate = moment(dateRange.split(' ~ ')[0]);
    var endDate = moment(dateRange.split(' ~ ')[1]);
    if (getDayOfWeek(startDate) == "Invalid date") {

    } else {

        var customText = dateRange + " (" + getDayOfWeek(startDate) + " ~ " + getDayOfWeek(endDate) + ")";
        $('#' + resultId).attr('placeholder', customText);
    }
}

function getDayOfWeek(date) {
    // moment.js를 사용하여 요일 문자열 가져오기
    return date.format('dddd');
}

function toggleApplyButton(selector, isEnabled) {

    const applyButton = $(selector).find('.daterangepicker .applyBtn');
    if (isEnabled) {
        applyButton.removeAttr('disabled');
    } else {
        applyButton.attr('disabled', 'disabled');
    }
}

$(function () {
    // 한국어 locale 사용
    moment.locale('ko');

    // 첫 번째 DateRangePicker
    $('#dateRangePicker').daterangepicker({
        "maxSpan": {
            "days": 10
        },
        minDate: moment(),
        startDate: moment().startOf('hour'),
        endDate: moment().startOf('hour').add(32, 'hour'),
        opens: 'center',
        autoUpdateInput: false,
        isInvalidDate: function () {

            if (this.endDate != null) {
                if (this.startDate.format('YYYY-MM-DD') == this.endDate.format('YYYY-MM-DD')) {
                    console.log(dd);
                }
            }
            return false;
        },
        locale: {
            format: 'YYYY-MM-DD',
            applyLabel: '적용',
            cancelLabel: '취소',
            fromLabel: '시작일',
            toLabel: '종료일',
            customRangeLabel: '사용자 정의 범위'
        }

    }, function (start, end, label) {

        StayDate = moment(end.format('YYYY-MM-DD')).diff(moment(start.format('YYYY-MM-DD')), 'days');
        var dateRange = start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD');
        updateCustomText(dateRange, 'dateRangePicker');
        updatehotelReserveStay(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'));

    });
    toggleApplyButton('#dateRangePicker', false);
    // 초기화면에도 적용하기 위해 한 번 호출
    var initialDateRange = $('#dateRangePicker').val();
    updateCustomText(initialDateRange, 'result1');

    // 두 번째 DateRangePicker
    $('#secondDateRangePicker').daterangepicker({
        minDate: moment(),
        startDate: moment().startOf('hour'),
        endDate: moment().startOf('hour').add(32, 'hour'),
        opens: 'left',
        autoUpdateInput: false,
        locale: {
            format: 'YYYY-MM-DD',
            applyLabel: '적용',
            cancelLabel: '취소',
            fromLabel: '시작일',
            toLabel: '종료일',
            customRangeLabel: '사용자 정의 범위'
        }
    });

});

//투숙일  input 
function updatehotelReserveStay(startDate, endDate) {
    document.getElementById('hotelReserveStayStart').value = startDate;
    document.getElementById('hotelReserveStayEnd').value = endDate;
}



//성인 버튼 조작
function addAudltCnt(int) {
    let cnt = parseInt(document.getElementById('audlt-Count').innerText);
    if (cnt < 30) {
        cnt += int;
        if (cnt == 0) {
            cnt = 1;
        }
    }
    document.getElementById('audlt-Count').innerText = cnt;
    AllPeopleCount();
}



//어린이 버튼 조작
document.getElementById("child+Btn").addEventListener('click', () => {
    let cnt = parseInt(document.getElementById('child-Count').innerText);
    if (cnt < 10) {
        cnt += 1;

    }


    document.getElementById('child-Count').innerText = cnt;
    AllPeopleCount();
    //  childAgeSelectCreater();
})

document.getElementById("child-Btn").addEventListener('click', () => {
    let cnt = parseInt(document.getElementById('child-Count').innerText);
    if (cnt > 0) {
        cnt -= 1;
    }
    document.getElementById('child-Count').innerText = cnt;
    AllPeopleCount();
    //  childAgeSelectCreater();
})

/**인원수 세주는거 */
function AllPeopleCount() {
    if (document.getElementById('child-Count').innerText != 0) {
        $('#people').attr('placeholder', `성인 ${document.getElementById('audlt-Count').innerText}명 · 아동 ${document.getElementById('child-Count').innerText}명 `);
    } else {
        $('#people').attr('placeholder', `성인 ${document.getElementById('audlt-Count').innerText}명`);
    }
    document.getElementById('hotelReservePeople').value = document.getElementById('audlt-Count').innerText;
    document.getElementById('hotelReserveChild').value = document.getElementById('child-Count').innerText;
}



// function childAgeSelectCreater(){
//   
//   let select ="";
//   for(let i = 1; i<=parseInt(document.getElementById('child-Count').innerText); i++){
//       
//      select+= `<select class="child-age-selecr">`;
//        select+=`<option value="">나이(필수 입력)</option>`;
//          for(let  i =0 ; i <17; i++){
//             select+= `<option value="${i}">${i}</option>`;
//         
//      }
//      select += `</select>`;   
//       }
//      console.log(select);
//      document.getElementById('chile-age').innerHTML = select;
//  
//  }
document.getElementById('people').addEventListener('click', () => {
    document.getElementById('peoplelist').style.display = "block";

})


//peoplelist 사라지는 이벤트
document.getElementById('peoplelistClose').addEventListener('click', () => {
    document.getElementById('peoplelist').style.display = "none";
})
var targetArea1 = document.getElementById('peoplelist');
var targetArea2 = document.getElementById('people');
document.addEventListener('click', function (event) {
    if (!targetArea1.contains(event.target) || !targetArea2.contains(event.target)) {

        document.getElementById('peoplelist').style.display = "none";
    }
});
targetArea1.addEventListener('click', function (event) {
    event.stopPropagation();
});
targetArea2.addEventListener('click', function (event) {
    event.stopPropagation();
});

//방 선택 이벤트
function roomSelectEvent(num) {
    if (StayDate == 1) { discountRate = 0 } if (StayDate == 2) { discountRate = 10 } if (StayDate == 3) { discountRate = 12 } if (StayDate == 4) { discountRate = 14 } if (StayDate == 5) { discountRate = 16 }
    if (StayDate == 6) { discountRate = 18 } if (StayDate == 7) { discountRate = 20 } if (StayDate == 8) { discountRate = 23 } if (StayDate == 9) { discountRate = 26 } if (StayDate == 10) { discountRate = 30 }
    roomprice = (document.getElementById('room' + num).value * StayDate) - (document.getElementById('room' + num).value * StayDate / 100 * discountRate);
    let roomname = document.getElementById('room' + num).innerText;
    let imageurl = document.getElementById('image-src' + num).innerText;


    //방 갯수 확인을 위한 value값
    document.getElementById('room-payinfo-num').value = num;
    document.getElementById('select' + num).checked = "true";




    //이미지 넣기
    document.getElementById('room-image').style.backgroundImage = `url(${imageurl})`;

    //이미지 아래 사진넣기
    document.getElementById('room-name').innerText = roomname;

    //상세보기 넣기
    document.getElementById('room-explain').innerHTML = "<a  target='_blank' style='text-decoration: none; color: black;'  href='/hotel/roomDetail?roomNum=" + num + "'> 방 상세보기</a>";


    //요금표시
    realAmount =  Math.floor(roomprice);
    document.getElementById('productPrice').value = Math.floor(roomprice);
    document.getElementById('pay1').value = Math.floor(roomprice).toLocaleString() + "원";
    document.getElementById('realpayvalue').value = Math.floor(roomprice);

    //상품명
    if (StayDate == 1) {
        document.getElementById('item-name').innerText = roomname;
    } else {
        document.getElementById('item-name').innerText = roomname + '(' + (StayDate - 1) + '박' + StayDate + '일)';
    }



    // if(할인율){
    //     document.getElementById('pay2').value = (roomprice*할인율)+;

    // }

}
document.getElementById('submitBtn').addEventListener('click', () => {
    if (pay1.value == "") {
        alert("방을 선택해주세요");
    } else {
        document.getElementById('modal-btn').click();
    }

})
