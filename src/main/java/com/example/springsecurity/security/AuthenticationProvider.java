//package com.example.springsecurity.security;
//
//import com.example.springsecurity.services.PersonDetailsService;
//import org.springframework.security.authentication.BadCredentialsException;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.stereotype.Component;
//
//import java.util.Collections;
//
//@Component
//public class AuthenticationProvider implements org.springframework.security.authentication.AuthenticationProvider {
//
//    private final PersonDetailsService personDetailsService;
//
//    public AuthenticationProvider(PersonDetailsService personDetailsService) {
//        this.personDetailsService = personDetailsService;
//    }
//
//    @Override
//    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
//        // получаем логин с формы аутентификации. За нас spring security сам создаст объект формы и передаст его в объект аутентификации
//        String login = authentication.getName();
//
//        // данный метод возвращает объект интерфейса UserDetails то и объект мы создадим через интерфейс
//        UserDetails person = personDetailsService.loadUserByUsername(login);
//
//        String password = authentication.getCredentials().toString();
//
//        if (!password.equals(person.getPassword())){
//            throw new BadCredentialsException("Не корректный пароль");
//        }
//
//        // возвращает объект пользователя с логином, паролеи и списком его ролей
//        return new UsernamePasswordAuthenticationToken(person, password, Collections.emptyList());
//    }
//
//    @Override
//    public boolean supports(Class<?> authentication) {
//        return true;
//    }
//}
