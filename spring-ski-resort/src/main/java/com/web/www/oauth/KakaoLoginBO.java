package com.web.www.oauth;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;


@Component
@Slf4j
@PropertySource("classpath:outApiProperties.properties")
public class KakaoLoginBO {
	
	@Value("${oauth.kakao.id}")
	private String kakao_clientId;

	
	public String getAccessToken (String authorize_code) throws ParseException {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
            
			sb.append("&client_id="+kakao_clientId); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8089/oauth/kakao/callback"); // 본인이 설정한 주소
            
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			log.info("responseCode = {} ", responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.info("response body = {} ", result);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(result); 
			JSONObject jsonObj = (JSONObject) obj; 
			
			access_Token = (String)jsonObj.get("access_token");
			refresh_Token = (String)jsonObj.get("refresh_token");
   
			log.info("access_token = {} " , access_Token);
			log.info("refresh_token = {} " , refresh_Token);
            
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}

	
}
