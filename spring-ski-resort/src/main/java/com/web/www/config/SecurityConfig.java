package com.web.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.web.www.security.CustomAuthMemberService;
import com.web.www.security.LoginFailureHandler;
import com.web.www.security.LoginSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	
	// 비밀번호 암호화 라이브러리
	@Bean
	public PasswordEncoder bdPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// UserDetail(DB접근 전 객체) 빈 객체 생성
	@Bean
	public UserDetailsService customUserService() {
		return new CustomAuthMemberService();
	}

	// SuccessHandler(성공시 저장객체) 빈 객체 생성
	@Bean
	public AuthenticationSuccessHandler authSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	// FaulureHandler(실패시 저장 객체) 빈 객체 생성 
	@Bean
	public AuthenticationFailureHandler authFailureHandler() {
		return new LoginFailureHandler();
	}
	
	
	//로그인 사용자에 대한 정보
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserService())
		.passwordEncoder(bdPasswordEncoder());	//비밀번호 암호화
	}


	//시큐리티 필터 체인
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();

		//OAuth접근시 UTF-8 필터 필요
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);		
		http.addFilterBefore(filter, CsrfFilter.class);


		//http의 승인요청 담당
		http.authorizeRequests()
		.antMatchers("/developer/**").hasRole("ADMIN")
		.antMatchers("/","/board/*","/upload/**","/resources/**",
				"/member/login","/member/register","/rental/**","/hotel/*","/member/check/**",
				"/oauth/*","/oauth/naver/*","/oauth/kakao/*","/oauth/google/*","/notice/**","/weather/**",
				"/pay/**","/qna/**","/developer/**","/resort/**","/member/findId","/member/findPwd","/member/findIdResult",
				"/alarm/**","/bus/**").permitAll()	//게스트 이용가능한 URL매핑
		.anyRequest().authenticated();	// 나머지 사용자 처리
		
		
		
		
		//커스텀 페이지 구성
		http.formLogin()
		.usernameParameter("memberId")
		.passwordParameter("memberPwd")
		.loginPage("/member/login")
		.successHandler(authSuccessHandler())
		.failureHandler(authFailureHandler());
		
		//로그아웃 페이지 구성
		http.logout()
		.logoutUrl("/member/logout")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		.logoutSuccessUrl("/");	//홈으로
	
	}


}
