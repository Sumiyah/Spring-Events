package com.sumiyah.events.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sumiyah.events.models.Event;
import com.sumiyah.events.models.User;
import com.sumiyah.events.services.EventService;
import com.sumiyah.events.services.UserService;
import com.sumiyah.events.validator.UserValidator;

@Controller
public class HomeController {

	@Autowired
	private final UserService userService;
	@Autowired
	private final EventService eventService;
	@Autowired
	private final UserValidator userValidator;

	public HomeController(UserService userService, EventService eventService, UserValidator userValidator) {
		this.userService = userService;
		this.eventService = eventService;
		this.userValidator = userValidator;
	}

	@RequestMapping("/")
	public String redirect(@ModelAttribute("user") User user) {
		return "welcome.jsp";
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		// if result has errors, return the registration page (don't worry about
		// validations just now)
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "welcome.jsp";
		} else {
			// else, save the user in the database, save the user id in session, and
			// redirect them to the /home route
			this.userService.registerUser(user);
			session.setAttribute("user_id", user.getId());
			return "redirect:/home";
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpSession session) {
		// if the user is authenticated, save their user id in session
		if (this.userService.authenticateUser(email, password)) {
			User user = this.userService.findByEmail(email);
			session.setAttribute("user_id", user.getId());
			return "redirect:/home";
		} else {
			// else, add error messages and return the login page
			model.addAttribute("error", "Invalid Credentials! Try again..");
			return "welcome.jsp";
		}
	}

	@RequestMapping("/home")
	public String home(@ModelAttribute("event") Event event, HttpSession session, Model model) {
		// if we're logged in we get back a user
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		// get user from session, save them in the model and return the home page
		model.addAttribute("user", this.userService.findUserById((Long) session.getAttribute("user_id")));
		model.addAttribute("stateEvent", this.eventService.eventInState(loggedInUser.getState()));
		model.addAttribute("notStateEvent", this.eventService.eventNotInState(loggedInUser.getState()));
		return "home.jsp";
	}

	@RequestMapping(value = "/createEvent", method = RequestMethod.POST)
	public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		
		if(result.hasErrors()) {
			model.addAttribute("user", this.userService.findUserById((Long) session.getAttribute("user_id")));
			return "home.jsp";
		}
		event.setUser(loggedInUser);
		eventService.create(event);
		return "redirect:/home";
		
	}
	
	@RequestMapping("/events/{id}")
	public String showEvent(@PathVariable("id") Long id, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		model.addAttribute("event", this.eventService.findById(id));
		return "show.jsp";
	}
	
	@RequestMapping("/events/{id}/edit")
	public String editEvent(@PathVariable("id") Long id, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		model.addAttribute("event", this.eventService.findById(id));
		return "edit.jsp";
	}
	
	@PostMapping("/updateEvent/{id}")
	public String updateEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		
		if(result.hasErrors()) {
//			model.addAttribute("user", this.userService.findUserById((Long) session.getAttribute("user_id")));
			return "edit.jsp";
		}
		
		model.addAttribute("event", this.eventService.findById(event.getId()));
		event.setUser(this.userService.findUserById((Long) session.getAttribute("user_id")));
		this.eventService.update(event);
		return "redirect:/events/"+event.getId();
	}
	
	
	@RequestMapping("/events/{id}/delete")
	public String deleteEvent(@PathVariable("id") Long id, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		this.eventService.delete(id);
//		model.addAttribute("event", this.eventService.findById(id));
		return "redirect:/home";
	}
	
	@RequestMapping("/events/{id}/join")
	public String joinEvent(@PathVariable("id") Long id, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		
		this.eventService.joinThisEvent(id, loggedInUser.getId());
		return "redirect:/home";
	}
	
	@RequestMapping("/events/{id}/leave")
	public String leaveEvent(@PathVariable("id") Long id, HttpSession session, Model model) {
		User loggedInUser = userService.findUserById((Long) session.getAttribute("user_id"));
		if (loggedInUser == null) {
			// if the user is null return them to the login form
			return "redirect:/";
		}
		
		this.eventService.leaveThisEvent(id, loggedInUser.getId());
		return "redirect:/home";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		// invalidate session
//    	session.setAttribute("user", null);
		session.invalidate();
		// redirect to login page
		return "redirect:/";
	}
}
