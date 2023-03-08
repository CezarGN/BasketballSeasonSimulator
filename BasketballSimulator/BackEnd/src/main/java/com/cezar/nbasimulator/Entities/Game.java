package com.cezar.nbasimulator.Entities;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "Game")
public class Game {
    @Id
    @GeneratedValue
    Long id;

    @ManyToOne
    @JoinColumn(name = "team_id1", nullable = false)
    private Team team1;
    @ManyToOne
    @JoinColumn(name = "team_id2", nullable = false)
    private Team team2;
    @ManyToOne
    @JoinColumn(name = "team_id_winner", nullable = false)
    private Team winner;
}
