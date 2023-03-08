package com.cezar.nbasimulator.repositories;

import com.cezar.nbasimulator.Entities.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamRepository extends JpaRepository<Team, Long> {
    public Team findTeamByName(String name);
}
