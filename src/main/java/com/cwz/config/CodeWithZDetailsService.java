package com.cwz.config;

import com.cwz.model.Customer;
import com.cwz.repository.CustomerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CodeWithZDetailsService implements UserDetailsService {

    CustomerRepository customerRepository;

    @Autowired
    public CodeWithZDetailsService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Customer customer=customerRepository.findCustomerByEmail(username)
                .orElseThrow(
                        ()-> new UsernameNotFoundException("User not found for "+username)
                );

        List<GrantedAuthority> authorities=List.of(
                new SimpleGrantedAuthority(customer.getRole())
        );

        return new User(customer.getEmail(),customer.getPwd(),authorities);
    }
}
