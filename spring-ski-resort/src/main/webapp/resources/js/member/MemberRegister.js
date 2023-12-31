
//약관
document.getElementById('flexCheckDefault').addEventListener('click', () => {

    if (document.getElementById('flexCheckDefault').checked == true) {
        for (let i = 1; i <= 3; i++) {
            document.getElementById(`flexCheckDefault-${i}`).checked = true;
            document.getElementById(`terms${i}`).disabled = true;
        }
    } else {
        for (let i = 1; i <= 3; i++) {
            document.getElementById(`flexCheckDefault-${i}`).checked = false;
            document.getElementById(`terms${i}`).disabled = false;
        }
    }
})

document.getElementById('flexCheckDefault-1').addEventListener('click', () => {
    if (document.getElementById('flexCheckDefault-1').checked == true) {
        document.getElementById(`terms1`).disabled = true;
    } else {
        document.getElementById(`terms1`).disabled = false;
    }
})
document.getElementById('flexCheckDefault-2').addEventListener('click', () => {
    if (document.getElementById('flexCheckDefault-2').checked == true) {
        document.getElementById(`terms2`).disabled = true;
    } else {
        document.getElementById(`terms2`).disabled = false;
    }
})
document.getElementById('flexCheckDefault-3').addEventListener('click', () => {
    if (document.getElementById('flexCheckDefault-3').checked == true) {
        document.getElementById(`terms3`).disabled = true;
    } else {
        document.getElementById(`terms3`).disabled = false;
    }
})

//비밀번호 확인
document.getElementById('exampleInputPassword2').addEventListener('keyup', () => {
    pwd1 = document.getElementById('exampleInputPassword1').value;
    pwd2 = document.getElementById('exampleInputPassword2').value;
    if (pwd1 == null || pwd1 == '') {
        document.getElementById('exampleInputPassword2').className = 'form-control';
        return;
    }

    if (pwd1 == pwd2) {
        document.getElementById('exampleInputPassword2').className = 'form-control is-valid';
    } else {
        document.getElementById('exampleInputPassword2').className = 'form-control is-invalid';
    }
})


//중복 인증관련
/*아이디 중복*/
document.getElementById('MemberIdCheck').addEventListener('click', () => {
    const id = document.getElementById('inputMemberId').value;
    idCheck(id).then(result => {
        if (result > 0) {
            document.getElementById('inputMemberId').className = 'form-control is-invalid';
            document.getElementById('duplicateIdCheck').innerText = '아이디가 이미 존재합니다.';
            document.getElementById('duplicateIdCheck').style.color = 'red';
        } else {
            document.getElementById('inputMemberId').className = 'form-control is-valid';
            document.getElementById('duplicateIdCheck').innerText = '사용가능';
            document.getElementById('duplicateIdCheck').style.color = 'green';
        }
    });

})

async function idCheck(id) {
    try {
        const url = "/member/check/id/" + id;
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//form 태그 호출 전 마지막 체크 함수
async function registerLastCheck(event) {
    event.preventDefault(); // 폼 제출 방지

    // 아이디 중복체크
    const id = document.getElementById('inputMemberId').value;
    console.log(id);
    try {
        const result = await idCheck(id);
        if (result > 0) {
            alert('아이디 중복 체크를 해주세요.');
            return false;
        }

        // 비밀번호체크
        const pwd1 = document.getElementById('exampleInputPassword1').value;
        const pwd2 = document.getElementById('exampleInputPassword2').value;
        if (pwd1 != pwd2) {
            document.getElementById('pwdCheck').innerHTML = '비밀번호를 확인해주세요'
            return false;
        }

        // 중복 체크 및 비밀번호 체크 통과 시에 폼 제출
        event.target.submit(); // 폼 제출
    } catch (error) {
        console.error(error); // 오류 처리
        return false;
    }
}




/*이메일 인증*/
// 중복체크
async function emailCheck(email) {
    try {
        const url = "/member/check/email/" + email;
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
// 인증로직
async function emailNumCheck(email) {
    try {
        const url = "/member/check/num/" + email;
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById('modalEmailCheckBtn').addEventListener('click', () => {
    const email = document.getElementById('modalEmailCheck').value;
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    document.getElementById('emailCheckSuccess').disabled = 'disabled';

    if (!emailPattern.test(email)) {
        document.getElementById('modalEmailCheck').className = 'form-control is-invalid';
        document.getElementById('emailDuplicateCheck').innerText = '유효하지 않은 이메일입니다.';
        document.getElementById('emailDuplicateCheck').style.color = 'red';
        return;
    }


    emailCheck(email).then(result => {

        if (result > 0) {
            document.getElementById('modalEmailCheck').className = 'form-control is-invalid';
            document.getElementById('emailDuplicateCheck').innerText = '가입된 이메일이 이미 존재합니다.';
            document.getElementById('emailDuplicateCheck').style.color = 'red';
        } else {
            document.getElementById('modalEmailCheck').className = 'form-control is-valid';
            document.getElementById('emailDuplicateCheck').innerText = '이메일을 확인해 주세요.';
            document.getElementById('emailDuplicateCheck').style.color = 'green';
            document.getElementById('modalEmailCheckBtn').disabled = true;



            let modalEmailNum = document.getElementById('modal-body2');
            modalEmailNum.innerHTML = '';

            let str = `<div class="form-group registerBox rb-5">`;
            str += `<label for="modalEmailCheck" class="form-label mt-4">인증번호</label>`;
            str += `<div class="input-group mb-3">`;
            str += `<input type="text" class="form-control" id="userAuthKey" aria-describedby="emailHelp" placeholder="인증번호" />`;
            str += `<button type="button" class="btn btn-primary" id="modalEmailCheckBtn2">인증번호 확인</button>`;
            str += `</div>`;
            str += `<div id="modalEmailMessage"></div>`;
            str += `</div>`;
            modalEmailNum.innerHTML += str;

            let serverAuthKey = 0;
            emailNumCheck(email).then(result => {
                serverAuthKey = result;
            });

            document.getElementById('modalEmailCheckBtn2').addEventListener('click', () => {
                console.log('사용자키 : ' + document.getElementById('userAuthKey').value);
                console.log('서버키 : ' + serverAuthKey);
                console.log('인증완료!');
                if (serverAuthKey != document.getElementById('userAuthKey').value ||
                    document.getElementById('userAuthKey').value == '' ||
                    document.getElementById('userAuthKey').value == null) {

                    console.log('인증실패!');
                    document.getElementById('userAuthKey').className = 'form-control is-invalid';
                    document.getElementById('modalEmailMessage').innerText = '인증번호를 확인해주세요.';
                    document.getElementById('modalEmailMessage').style.color = 'red';

                } else {

                    document.getElementById('modalEmailCheckBtn2').disabled = true;
                    document.getElementById('userAuthKey').className = 'form-control is-valid';
                    document.getElementById('modalEmailMessage').innerText = '인증완료 버튼을 누르세요.';
                    document.getElementById('modalEmailMessage').style.color = 'green';
                    document.getElementById('emailCheckSuccess').disabled = false;
                    document.getElementById('inputMemberEmail').value = email;

                }
            })


        }

    })

    document.getElementById('emailCheckSuccess').addEventListener('click', () => {
        document.getElementById('modalClose').click();
    })


})


function emailNumStartTimer() {
    let timer;
    let timeLeft = 180;


}




// 주소 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("inputMemberAddress").value = extraAddr;

            } else {
                document.getElementById("inputMemberAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('inputMemberPostcode').value = data.zonecode;
            document.getElementById("inputMemberAddress").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("inputMemberAddressDetail").focus();
        }
    }).open();
}

//모달창 약관체크
document.getElementById('ModalflexCheckDefault').addEventListener('click', () => {
    document.getElementById('modalCloseClick').click();
    document.getElementById('flexCheckDefault').click();
})

//키보드 입력시 아이디 중복확인
function chaekId() {
    document.getElementById('MemberIdCheck').click();
}

//이메일 입력창 띄우기
document.getElementById('inputMemberEmail').addEventListener('click', () => {
    document.getElementById('MemberEmailCheck').click();

})


//전화번호 입력시 값 보내기
function printNum() {
    let num1 = document.getElementById('phoneNum1').value;
    let x = document.getElementById('phoneNum2').value;

    let num2 = x.slice(0, 3) + '-' + x.slice(3);

    if (x.length == 8) {
        num2 = x.slice(0, 4) + '-' + x.slice(4);
    }


    document.getElementById("inputMemberPhone").value = num1 + "-" + num2;
}

//주소찾기 띄우기
function clickAddr() {
    document.getElementById('button-addon2').click();
}



