package world.qode.app;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class HomeControllerTests {

	@Test
	void healthIsOk() {
		assertThat(new HomeController().health()).containsEntry("status", "ok");
	}

}
