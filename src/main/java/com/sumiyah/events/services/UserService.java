package com.sumiyah.events.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sumiyah.events.models.User;
import com.sumiyah.events.repositories.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository uRepo;
	
	public UserService (UserRepository uRepo) {
		this.uRepo = uRepo;
	}
	
	//Add new User
	public User registerUser(User user) {
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashed);
		return uRepo.save(user);
	}
	
	public User findByEmail(String email) {
		return uRepo.findByEmail(email);
		
	}
	
	public User findUserById(Long id) {
		Optional<User> u = uRepo.findById(id);
		if (u.isPresent()) {
			return u.get();
		} else {
			return null;
		}
	}
	
	//check if user exist
	public boolean authenticateUser(String email, String password) {
		User user = uRepo.findByEmail(email);
		
		if(user == null) {
			return false;
		} else {
			if(BCrypt.checkpw(password, user.getPassword())) {
				return true;
			} else {
				return false;
			}
		}
	}
}
