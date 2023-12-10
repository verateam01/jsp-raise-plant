package gpt;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import config.Config;




@WebServlet("/api/gpt")
public class OpenAIServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public OpenAIServlet() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String prompt =	request.getParameter("prompt");
        String apiKey = Config.getProperty("gpt.key"); // OpenAI API 키
        String data = "{\"model\": \"gpt-3.5-turbo-1106\", \"messages\": [{\"role\": \"user\", \"content\": \"" + prompt + "\"}], \"max_tokens\": 150}";
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
            .uri(URI.create("https://api.openai.com/v1/chat/completions"))
            .header("Content-Type", "application/json")
            .header("Authorization", "Bearer " + apiKey)
            .POST(HttpRequest.BodyPublishers.ofString(data))
            .build();

        try {
            HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
            System.out.println(httpResponse.body());
            JSONObject jsonObject = new	JSONObject(httpResponse.body());
            String gptResponse = jsonObject.getJSONArray("choices").getJSONObject(0).getJSONObject("message").getString("content");
            String jsonResponse = "{\"status\":\"success\", \"answer\":\"" + gptResponse + "\"}";
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
        	e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
