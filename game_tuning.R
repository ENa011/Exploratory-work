FLAGs <-flags(
  flag_numeric("nodes", 128),
  flag_numeric("nodes2", 30),
  flag_numeric("batch_size", 100),
  flag_string("activation", "relu"),
  flag_numeric("learning_rate", 0.01),
  flag_numeric("epochs",30),
  flag_numeric("drop1", 0.2),
  flag_numeric("drop2", 0.4)
)

model= keras_model_sequential()
model %>%
  layer_dense(units = FLAGs$nodes, activation = 
                FLAGs$activation) %>%
  layer_dropout(FLAGs$drop1) %>%
  layer_dense(units = FLAGs$nodes2, 
              activation = FLAGs$activation) %>%
  layer_dropout(FLAGs$drop2) %>%
  layer_dense(units = 1, activation = 'linear')

model %>% compile(
  optimizer = optimizer_adam(lr=FLAGs$learning_rate),
  loss = 'mean_squared_error',
  metrics = c('mae')
)

model %>% fit(df_train, (game_train2$Metacritic),
              epochs=FLAGs$epochs, batch_size=FLAGs$batch_size, 
              validation_data=list(df_val, game_val1$Metacritic)
)