package com.example.springsecurity.services;

import com.example.springsecurity.models.Person;
import com.example.springsecurity.repositories.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class PersonService {
    private final PersonRepository personRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public PersonService(PersonRepository personRepository, PasswordEncoder passwordEncoder) {
        this.personRepository = personRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Person findByLogin(Person person){
        Optional<Person> person_db=personRepository.findByLogin(person.getLogin());
        return person_db.orElse(null);
    }

    public Person findById(int id){
        Optional<Person> person = personRepository.findById(id);
        return person.orElse(null);
    }

    @Transactional
    public void register(Person person){
        person.setPassword(passwordEncoder.encode(person.getPassword()));
        person.setRole("ROLE_USER");
        personRepository.save(person);
    }

    public List<Person> findAll() {
        return personRepository.findAll();
    }

    @Transactional
    public void updatePerson(int id, Person person){
        person.setId(id);
        System.out.println(person.toString());
        personRepository.save(person);
    }

    @Transactional
    public void deletePersonById(int id){
        personRepository.deleteById(id);
    }
}
