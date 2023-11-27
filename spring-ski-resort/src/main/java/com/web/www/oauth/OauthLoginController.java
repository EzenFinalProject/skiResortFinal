package com.web.www.oauth;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.web.www.domain.member.MemberVO;
import com.web.www.security.AuthMember;
import com.web.www.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/oauth/*")
@PropertySource("classpath:outApiProperties.properties")
@RequiredArgsConstructor
public class OauthLoginController {

	private final MemberService msv;
	private final OauthParser parser;
	
	/**
	 * @NaverLoginBO 네이버 비즈니스 오브젝트(BO)입니다.  
	 * @카카오 카카오 비즈니스 오브젝트(BO)입니다.
	 * @구글	구글 비즈니스 오브젝트입니다(BO)입니다.
	 */
	private final NaverLoginBO naverLoginBO;
	private final KakaoLoginBO kakaoLoginBO;
	private final GoogleLoginBO googleLoginBO;
	

	/**
	 * @네이버
	 */
	
	// 로그인 첫 화면 요청
	@ResponseBody
	@GetMapping("/naver/login") 
	public String naverLogin(HttpSession session) { 
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */ 
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		log.info("네이버 url = {}" , naverAuthUrl); //네이버 
		return naverAuthUrl; 
	 }

	// 네이버 callback 호출
	@RequestMapping(value = "/naver/callback", method = {RequestMethod.GET, RequestMethod.POST }) 
	public String callback(Model model, @RequestParam String code, @RequestParam String state, 
			HttpSession session, RedirectAttributes rttr) 
			throws IOException, org.json.simple.parser.ParseException{ 
	
		OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		//로그인 사용자 정보를 읽어옵니다.
		String apiResult = null;
		apiResult = naverLoginBO.getUserProfile(oauthToken);	
		
		//JSON 유저 정보 파싱 -> 유저VO에 담기
		MemberVO mvo = parser.naverUser(apiResult);
		
		//정보가 세팅된 소셜유저 가입, 인증권한 세팅 메서드 
		socialUserCreateMemberAndAuthSet(mvo);
		
		return "redirect:/"; 
		
	}
	
	/**
	 * @카카오
	 */
	
	@Value("${oauth.kakao.url}")
	private String kakao_clientUrl;
	
	
	// 로그인 첫 화면 요청
	@ResponseBody
	@GetMapping("/kakao/login") 
	public String kakaoLogin() { 
		
		/* 카카오 아이디로 인증 URL을 생성하기 위하여 kakaoLoginBO클래스의 getAuthorizationUrl메서드 호출 */ 
		String kakaoAuthUrl = kakao_clientUrl;
		return kakaoAuthUrl; 
	 }
	// 카카오 callback 호출
	@RequestMapping(value = "/kakao/callback", method = {RequestMethod.GET, RequestMethod.POST }) 
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code) throws Exception {
		String access_Token = kakaoLoginBO.getAccessToken(code);
        
		// JSON 유저 정보 파싱 -> 유저VO에 담기
		MemberVO mvo = parser.kakaoUser(access_Token);

		//정보가 세팅된 소셜유저 가입, 인증권한 세팅 메서드
		socialUserCreateMemberAndAuthSet(mvo);
		
		return "redirect:/";
    	}
	
	/**
	 * @구글
	 */
	// 로그인 첫 화면 요청
	@ResponseBody
	@RequestMapping("/google/login")
	public String login(HttpServletRequest request) {
		//구글 code 발행
		String googleAuthUrl = googleLoginBO.getGoogleUrl();

		return  googleAuthUrl;
	}

	// 구글 Callback호출
	@RequestMapping(value = "/google/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(HttpServletRequest request, Model model, @RequestParam String code) throws IOException {
		
		Map<String, String> userInfo = googleLoginBO.getAccessToken(code);
	
		// JSON 유저 정보 파싱 -> 유저VO에 담기
		MemberVO mvo = parser.googleUser(userInfo);
		
		//정보가 세팅된 소셜유저 가입, 인증권한 세팅 메서드
		socialUserCreateMemberAndAuthSet(mvo);
	
		return "redirect:/";
	}
	
	//정보가 세팅된 소셜유저 가입, 인증권한 세팅 메서드 
	private void socialUserCreateMemberAndAuthSet(MemberVO mvo) {
		//DB에 소셜유저 검증 (없으면 DB에 저장 || 있으면 pass)
		if(msv.socialSearch(mvo.getMemberId()) == null) {
			int isOk = msv.socialRegister(mvo);
		}
		AuthMember OauthUser = new AuthMember(mvo);	//id , 비번만
		Authentication authentication = 
				new UsernamePasswordAuthenticationToken(OauthUser, null, OauthUser.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	
		
}	


