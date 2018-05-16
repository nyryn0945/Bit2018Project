package com.bitcamp.night.config;

import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;
import org.springframework.session.web.http.CookieSerializer;
import org.springframework.session.web.http.DefaultCookieSerializer;

@EnableRedisHttpSession
public class RedisConfig
{
	@Bean
	public LettuceConnectionFactory connectionFactory()
	{
		return new LettuceConnectionFactory();
	}

	@Bean
	public CookieSerializer cookieSerializer()
	{
		DefaultCookieSerializer serializer = new DefaultCookieSerializer();
		serializer.setUseBase64Encoding(false);
		serializer.setCookieName("JSESSIONID");
		serializer.setCookiePath("/");
		return serializer;
	}

	@Bean
	public RedisSerializer<Object> springSessionDefaultRedisSerializer()
	{
		return new GenericJackson2JsonRedisSerializer();
	}
}