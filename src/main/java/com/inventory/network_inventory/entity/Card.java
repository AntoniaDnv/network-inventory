package com.inventory.network_inventory.entity;

import com.inventory.network_inventory.entity.enums.CardStatus;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "card", uniqueConstraints = {
   @UniqueConstraint(name = "UQ_card_slot_id", columnNames = "slot_id"),
   @UniqueConstraint(name = "UQ_card_serial_number", columnNames = "serial_number")
})
public class Card {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private Long id;

   @OneToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "slot_id")
   private Slot slot;

   @Column(name = "part_number", length = 60, nullable = false)
   private String partNumber;

   @Column(name = "serial_number", length = 60, nullable = false)
   private String serialNumber;

   @Column(name = "card_type", length = 40, nullable = false)
   private String cardType;

   @Column(name = "port_count")
   private Integer portCount;

   @Column(name = "hardware_revision", length = 20)
   private String hardwareRevision;

   @Enumerated(EnumType.STRING)
   @Column(name = "status", length = 20, nullable = false)
   private CardStatus status;

   @CreationTimestamp
   @Column(name = "created_at", nullable = false, updatable = false)
   private LocalDateTime createdAt;

   @UpdateTimestamp
   @Column(name = "updated_at")
   private LocalDateTime updatedAt;

   public Long getId(){return id;}

   public Slot getSlot(){return slot;}
   public void setSlot(Slot slot){this.slot = slot;}

   public String getPartNumber(){return partNumber;}
   public void setPartNumber(String partNumber){this.partNumber = partNumber;}

   public String getSerialNumber(){return serialNumber;}
   public void setSerialNumber(String serialNumber){this.serialNumber = serialNumber;}

   public String getCardType(){return cardType;}
   public void setCardType(String cardType){this.cardType = cardType;}

   public Integer getPortCount(){return portCount;}
   public void setPortCount(Integer portCount){this.portCount = portCount;}

   public String getHardwareRevision(){return hardwareRevision;}
   public void setHardwareRevision(String hardwareRevision){this.hardwareRevision = hardwareRevision;}

   public CardStatus getStatus(){return status;}
   public void setStatus(CardStatus status){this.status = status;}

   public LocalDateTime getCreatedAt(){return createdAt;}
   public LocalDateTime getUpdatedAt(){return updatedAt;}
}
