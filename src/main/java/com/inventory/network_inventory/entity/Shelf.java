package com.inventory.network_inventory.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "shelf", uniqueConstraints = {
   @UniqueConstraint(name = "UQ_shelf_router_number", columnNames = {"router_id", "shelf_number"})
})
public class Shelf {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private Long id;

   @ManyToOne(fetch = FetchType.LAZY, optional = false)
   @JoinColumn(name = "router_id", nullable = false)
   private Router router;

   @Column(name = "shelf_number", nullable = false)
   private Integer shelfNumber;

   @Column(name = "shelf_type", length = 60)
   private String shelfType;

   @Column(name = "serial_number", length = 60)
   private String serialNumber;

   @Column(name = "total_slots", nullable = false)
   private Integer totalSlots;

   @Column(name = "status", length = 20, nullable = false)
   private String status;

   @CreationTimestamp
   @Column(name = "created_at", nullable = false, updatable = false)
   private LocalDateTime createdAt;

   @UpdateTimestamp
   @Column(name = "updated_at")
   private LocalDateTime updatedAt;

   @OneToMany(mappedBy = "shelf")
   private List<Slot> slots = new ArrayList<>();

   public Long getId(){return id;}

   public Router getRouter(){return router;}
   public void setRouter(Router router){this.router = router;}

   public Integer getShelfNumber(){return shelfNumber;}
   public void setShelfNumber(Integer shelfNumber){this.shelfNumber = shelfNumber;}

   public String getShelfType(){return shelfType;}
   public void setShelfType(String shelfType){this.shelfType = shelfType;}

   public String getSerialNumber(){return serialNumber;}
   public void setSerialNumber(String serialNumber){this.serialNumber = serialNumber;}

   public Integer getTotalSlots(){return totalSlots;}
   public void setTotalSlots(Integer totalSlots){this.totalSlots = totalSlots;}

   public String getStatus(){return status;}
   public void setStatus(String status){this.status = status;}

   public LocalDateTime getCreatedAt(){return createdAt;}
   public LocalDateTime getUpdatedAt(){return updatedAt;}

   public List<Slot> getSlots(){return slots;}
}
