package world.qode.app;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class HomeController {

	@GetMapping("/")
	Map<String, String> home() {
		return Map.of("app", "spring-boot-template", "status", "ok");
	}

	// The fleet's health check (fleet.conf HEALTH_PATH). Actuator's richer
	// /actuator/health is also on.
	@GetMapping("/health")
	Map<String, String> health() {
		return Map.of("status", "ok");
	}

}
