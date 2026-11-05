package com.inventory.network_inventory.entity;

import com.inventory.network_inventory.entity.enums.SlotStatus;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "slot", uniqueConstraints = {
   @UniqueConstraint(name = "UQ_slot_slot_number", columnNames = {"shelf_id", "slot_number"})
})
public class Slot {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private Long id;

   @ManyToOne(fetch = FetchType.LAZY, optional = false)
   @JoinColumn(name = "shelf_id", nullable = false)
   private Shelf shelf;

   @Column(name = "slot_number", nullable = false)
   private Integer slotNumber;

   @Column(name = "slot_type", length = 60)
   private String slotType;

   @Enumerated(EnumType.STRING)
   @Column(name = "status", length = 20, nullable = false)
   private SlotStatus status;

   @CreationTimestamp
   @Column(name = "created_at", nullable = false, updatable = false)
   private LocalDateTime createdAt;

   @UpdateTimestamp
   @Column(name = "updated_at")
   private LocalDateTime updatedAt;

   @OneToOne(mappedBy = "slot", fetch = FetchType.LAZY)
   private Card card;

   public Long getId(){return id;}

   public Shelf getShelf(){return shelf;}
   public void setShelf(Shelf shelf){this.shelf = shelf;}

   public Integer getSlotNumber(){return slotNumber;}
   public void setSlotNumber(Integer slotNumber){this.slotNumber = slotNumber;}

   public String getSlotType(){return slotType;}
   public void setSlotType(String slotType){this.slotType = slotType;}

   public SlotStatus getStatus(){return status;}
   public void setStatus(SlotStatus status){this.status = status;}

   public LocalDateTime getCreatedAt(){return createdAt;}
   public LocalDateTime getUpdatedAt(){return updatedAt;}

   public Card getCard(){return card;}
}
