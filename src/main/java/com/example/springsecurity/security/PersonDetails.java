package com.example.springsecurity.security;

import com.example.springsecurity.models.Person;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

public class PersonDetails implements UserDetails {

    private final Person person;

    public PersonDetails(Person person) {
        this.person = person;
    }

    public Person getPerson(){
        return this.person;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority(person.getRole()));
    }

    @Override
    public String getPassword() {
        return this.person.getPassword();
    }

    @Override
    public String getUsername() {
        return this.person.getLogin();
    }

    // аккаунт активный (действителен)?
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // заблокирован ли аккаунт
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // действительность пароля
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // являктся ли сейчас активным?
    @Override
    public boolean isEnabled() {
        return true;
    }
}
