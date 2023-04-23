package com.example.springsecurity.config;

//import com.example.springsecurity.security.AuthenticationProvider;
import com.example.springsecurity.services.PersonDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.proxy.NoOp;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

//    private final AuthenticationProvider authenticationProvider;
//
//    public SecurityConfig(AuthenticationProvider authenticationProvider) {
//        this.authenticationProvider = authenticationProvider;
//    }
//
//    // сначала при аутентификаци сработает этот метод и он скажет куда обращаться
//    protected void configure(AuthenticationManagerBuilder authenticationManagerBuilder){
//        authenticationManagerBuilder.authenticationProvider(authenticationProvider);
//    }

    private final PersonDetailsService personDetailsService;

    // убираем шифрование паролей (для тестирования приложения)
//    @Bean
//    public PasswordEncoder getPasswordEncoder(){
//        return NoOpPasswordEncoder.getInstance();
//    }

    @Bean
    public PasswordEncoder getPasswordEncoder(){

        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // конфигурируем работу Spring Security
        http
//        http.csrf().disable() // отключаем csrf токены (отключаем защиту от межсайтовой подделки запросов)
                .authorizeHttpRequests() // указываем , что все станицы должнф быть защищены ацтентификацией
                .requestMatchers("/admin").hasRole("ADMIN") // указываем что страница /admin доступна пользователям с ролью ADMIN
                //указываем что неаутентифицированные пользователи могут зайти на страницу аутентификаиции и на объект ошибки
                // с помощью permitAll указываем что неаутентифицированные пльзователи могут заходить на перечисленные страницы
                .requestMatchers("/authentication", "/error", "/registration", "/resources/**", "/static/**", "/css/**", "/js/**", "/img/**", "/product", "/product/info/{id}", "/product/search").permitAll()
                // указывае что для всех остальных страниц необходимо вызвать метод authenticated() который открывает форму аутентификаци
//                .anyRequest().authenticated()
                .anyRequest().hasAnyRole("USER", "ADMIN") //указываем что все остальные страницы доступны указанным ролям
                .and() //указывает что дальше настраивается аутентификация и соедиянем ее с нстройкой доступа
                .formLogin().loginPage("/authentication") // указываем какой url запрос будет отправлятся при заходе на защищенные старницы
                .loginProcessingUrl("/process_login") // указываем на какой адрес будет отправлятьяс данные с формы. Нам уже не нужно будет создавать сетод в контрллере и обрабатывать данные с формы. Мы задали url, который используется по умолчанию для обработки формы аутентификации по средствам Spring Security. Spring Security будет ждат ьобъект с формы аутентификации и затем сверять логин и пароль с данными БД
                .defaultSuccessUrl("/personal_account", true) // указываем на какой url необходимо направить пользователя после успешной аутентификации. Вторым аргументом указывается екгу чтобы перенаправление шло в любом случае после успешной аутентификации
                .failureUrl("/authentication?error")// указываем куда необходимо перенаправлять пользователя на проваленной аутентификации. В запрос будет передан объект error, который будет проверятся на форме и при наличии данного объекта в запросе выводится сообщение "Неправильныцй логин или пароль"
                .and()
                .logout().logoutUrl("/logout").logoutSuccessUrl("/authentication");// Spring сам удалит сессию пользователя
        return http.build();
    }

    @Autowired
    public SecurityConfig(PersonDetailsService personDetailsService) {
        this.personDetailsService = personDetailsService;
    }

    protected void configure(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
        authenticationManagerBuilder.userDetailsService(personDetailsService)
                .passwordEncoder(getPasswordEncoder());
    }
}
