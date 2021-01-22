package com.sumiyah.events.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sumiyah.events.models.Event;
import com.sumiyah.events.models.User;
import com.sumiyah.events.repositories.EventRepository;
import com.sumiyah.events.repositories.UserRepository;

@Service
public class EventService {

	@Autowired 
	private EventRepository eRepo;
	@Autowired 
	private UserRepository uRepo;
	
	public EventService(EventRepository eRepo) {
		this.eRepo = eRepo;
	}
	
	public List<Event> eventInState(String state){
		return this.eRepo.findByState(state);
	}
	
	public List<Event> eventNotInState(String state){
		return this.eRepo.findByStateIsNot(state);
	}
	
	public Event findById(Long id) {
		return this.eRepo.findById(id).orElse(null);
	}
	
	public Event create(Event e) {
		return this.eRepo.save(e);
	}
	
	public Event update(Event e) {
		return this.eRepo.save(e);
	}
	
	public void delete(Long id) {
		this.eRepo.deleteById(id);
	}
	
	public void joinThisEvent(Long event_id, Long user_id) {
		User user = uRepo.findById(user_id).orElse(null);
		Event event = findById(event_id);
		List<User> attend = event.getAttendance();
		attend.add(user);
		event.setAttendance(attend);
		eRepo.save(event);
	}
	
	public void leaveThisEvent(Long event_id, Long user_id) {
		User user = uRepo.findById(user_id).orElse(null);
		Event event = findById(event_id);
		List<User> attend = event.getAttendance();
		attend.remove(user);
		event.setAttendance(attend);
		eRepo.save(event);
	}
}
