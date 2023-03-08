package com.cezar.nbasimulator.Entities;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "Team")
public class Team {
    @Id
    @GeneratedValue
    @Column(name = "team_id", nullable = false)
    Long id;
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "rating", nullable = false)
    private int rating;
    @Column(name = "wins", nullable = true)
    private int wins;
    @Column(name = "losses", nullable = true)
    private int loses;

}
