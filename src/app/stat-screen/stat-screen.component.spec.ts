import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StatScreenComponent } from './stat-screen.component';

describe('StatScreenComponent', () => {
  let component: StatScreenComponent;
  let fixture: ComponentFixture<StatScreenComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StatScreenComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StatScreenComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
